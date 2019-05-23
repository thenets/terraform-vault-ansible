variable "aws_access_key" {}
variable "aws_secret_key" {}

# AWS South America
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "sa-east-1"
}
