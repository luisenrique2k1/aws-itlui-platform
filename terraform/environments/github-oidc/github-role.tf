
data "aws_iam_policy_document" "cloudformation_github_trust" {
  statement {
    sid     = "AllowGitHubMainBranch"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:luisenrique2k1@223758284/aws-itlui-platform@1455644307:ref:refs/heads/main"
      ]
    }
  }
}

resource "aws_iam_role" "cloudformation_github" {
  name = "itlui-cloudformation-github-role"

  assume_role_policy = data.aws_iam_policy_document.cloudformation_github_trust.json

  tags = {
    Project   = "itlui-cloudformation-lab"
    ManagedBy = "Terraform"
  }
}

output "cloudformation_github_role_arn" {
  description = "IAM role for GitHub Actions CloudFormation authentication"
  value       = aws_iam_role.cloudformation_github.arn
}
