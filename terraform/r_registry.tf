resource "aws_ecr_repository" "accounts_api" {
  name = "accounts/api"
}

resource "aws_ecr_repository" "accounts_manager" {
  name = "accounts/manager"
}
