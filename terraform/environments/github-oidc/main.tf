
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = {
    Project   = "itlui-cloudformation-lab"
    ManagedBy = "Terraform"
  }
}

output "github_oidc_provider_arn" {
  value = aws_iam_openid_connect_provider.github.arn
}
