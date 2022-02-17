
data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = format("%s-default-policy-%s", local.name, var.env_name)
  statement {
    actions = [
      "SNS:Publish"
    ]
    condition {
      test     = "ArnLike"
      variable = "AWS:SourceArn"

      values = [
        module.s3_bucket.s3_bucket_arn
      ]
    }
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    resources = [
      aws_sns_topic.this.arn,
    ]
  }
}