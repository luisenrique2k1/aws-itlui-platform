# CloudFormation service trust policy

data "aws_iam_policy_document" "cloudformation_execution_trust" {
  statement {
    sid     = "AllowCloudFormationService"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudformation.amazonaws.com"]
    }
  }
}

# Dedicated execution role

resource "aws_iam_role" "cloudformation_execution" {
  name = "itlui-cloudformation-execution-role"

  assume_role_policy = data.aws_iam_policy_document.cloudformation_execution_trust.json

  tags = {
    Project   = "itlui-cloudformation-lab"
    ManagedBy = "Terraform"
  }
}

output "cloudformation_execution_role_arn" {
  description = "Dedicated execution role for the CloudFormation S3 lab"
  value       = aws_iam_role.cloudformation_execution.arn
}

# S3 permissions for the existing CloudFormation lab bucket

data "aws_iam_policy_document" "cloudformation_s3_permissions" {
  statement {
    sid    = "ManageExistingLabBucket"
    effect = "Allow"

    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning",
      "s3:GetBucketPublicAccessBlock",
      "s3:PutBucketPublicAccessBlock",
      "s3:GetEncryptionConfiguration",
      "s3:PutEncryptionConfiguration",
      "s3:GetBucketTagging",
      "s3:PutBucketTagging",
      "s3:GetBucketPolicy",
      "s3:GetBucketAcl"
    ]

    resources = [
      "arn:aws:s3:::itlui-cfn-s3-lab-labbucket-6pi8dzn7ach2"
    ]
  }
}

resource "aws_iam_role_policy" "cloudformation_s3" {
  name = "itlui-cloudformation-s3-lab-policy"

  role   = aws_iam_role.cloudformation_execution.id
  policy = data.aws_iam_policy_document.cloudformation_s3_permissions.json
}