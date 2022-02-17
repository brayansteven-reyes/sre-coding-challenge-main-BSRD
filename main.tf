
locals {
  region = "us-east-1"
  common_tags = {
    Environment = var.env_name
    Owner       = "DevOps"
    ManagedBy   = "Terraform"
  }
  user_data = <<-EOT
    #!/bin/bash
    sudo su
    yum -y install httpd
    echo "<h1> My Challenge BSRD! </h1>" >> /var/www/html/index.html
    sudo systemctl enable httpd
    sudo systemctl start httpd
    EOT
  name      = "web-page"
}

resource "random_integer" "random" {
  min = 10000
  max = 50000
}

module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "3.12.0"
  name           = format("%s-vpc-%s", local.name, var.env_name)
  cidr           = "20.0.0.0/16"
  azs            = ["${local.region}a"]
  public_subnets = ["20.0.101.0/24"]
  tags           = local.common_tags
}

module "security_group" {
  source              = "terraform-aws-modules/security-group/aws"
  version             = "4.8.0"
  name                = format("%s-sg-%s", local.name, var.env_name)
  description         = "Security group for Web Aplication"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
  tags                = local.common_tags
}

module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "3.4.0"
  name                        = format("%s-ec2-%s", local.name, var.env_name)
  ami                         = "ami-00e87074e52e6c9f9"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  monitoring                  = true
  vpc_security_group_ids      = [module.security_group.security_group_id]
  subnet_id                   = element(module.vpc.public_subnets, 0)
  user_data_base64            = base64encode(local.user_data)
  tags                        = local.common_tags
}

module "s3_bucket" {
  source              = "terraform-aws-modules/s3-bucket/aws"
  version             = "2.14.1"
  bucket              = format("%s-bucket-%s-%s", local.name, random_integer.random.result, var.env_name)
  acl                 = "private"
  block_public_policy = true
  versioning = {
    enabled = true
  }
  tags = local.common_tags
}

resource "aws_sns_topic" "this" {
  name = format("%s-sns-topic-%s", local.name, var.env_name)
  tags = local.common_tags
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_s3_bucket_notification" "this" {
  bucket = module.s3_bucket.s3_bucket_id
  topic {
    topic_arn = aws_sns_topic.this.arn
    events    = ["s3:ObjectCreated:*"]
  }
  depends_on = [
    module.s3_bucket,
  ]
}

resource "aws_s3_bucket_object" "object" {
  bucket = module.s3_bucket.s3_bucket_id
  key    = "README.md"
  source = "README.md"
  depends_on = [
    aws_s3_bucket_notification.this,
  ]
}
