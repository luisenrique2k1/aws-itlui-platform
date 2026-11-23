# GitHub Actions permissions for the CloudFormation S3 lab

data "aws_iam_policy_document" "github_cloudformation_permissions" {

  # Allow operations on the specific CloudFormation stack
  statement {
    sid    = "ManageLabStack"
    effect = "Allow"

    actions = [
      "cloudformation:CreateChangeSet",
      "cloudformation:DescribeChangeSet",
      "cloudformation:DeleteChangeSet",
      "cloudformation:DescribeStacks",
      "cloudformation:GetTemplate",
      "cloudformation:ListStackResources"
    ]

    resources = [
      "arn:aws:cloudformation:eu-north-1:273422285435:stack/itlui-cfn-s3-lab/*",
      "arn:aws:cloudformation:eu-north-1:273422285435:changeSet/itlui-cfn-s3-lab-*/*"
    ]
  }

  # Allow passing only the dedicated execution role
  statement {
    sid    = "PassCloudFormationExecutionRole"
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = [
      aws_iam_role.cloudformation_execution.arn
    ]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["cloudformation.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "github_cloudformation" {
  name = "itlui-github-cloudformation-deployment-policy"

  role   = aws_iam_role.cloudformation_github.id
  policy = data.aws_iam_policy_document.github_cloudformation_permissions.json
}