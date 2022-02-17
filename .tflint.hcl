
plugin "aws" {
    enabled = true
    version = "0.8.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
    plugin_dir = ".tflint.d/plugins"
}
