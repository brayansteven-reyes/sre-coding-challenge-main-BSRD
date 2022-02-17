
variable "env_name" {
  description = "The environment to run the project"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "qa", "stg", "prod"], var.env_name)
    error_message = "Allowed values for input_parameter are \"dev\", \"qa\", \"stg\", or \"prod\"."
  }
}
