resource "aws_ssm_parameter" "gittokensecret" {
  name        = "/orgname/github/token"
  description = "github access token"
  type        = "SecureString"
  value       = var.github_token
  overwrite   = true

  tags = {
    environment = "qa"
  }
}

resource "aws_ssm_parameter" "gitusersecret" {
  name        = "/orgname/github/user"
  description = "github access user"
  type        = "SecureString"
  value       = var.github_user
  overwrite   = true

  tags = {
    environment = "qa"
  }
}