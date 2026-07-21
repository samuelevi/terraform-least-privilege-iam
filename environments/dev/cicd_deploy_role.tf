variable "ci_account_id" {
  description = "AWS account ID of the CI/CD system that is allowed to assume this role"
  type        = string
}

module "cicd_deploy_role" {
  source = "../../modules/iam-role"

  role_name = "cicd-deploy-role"

  trust_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${var.ci_account_id}:root"
      }
      Action = "sts:AssumeRole"
      Condition = {
        StringEquals = {
          "sts:ExternalId" = "iam-least-privilege-ci"
        }
      }
    }]
  })

  allowed_actions = [
    "s3:PutObject",
    "s3:GetObject",
    "cloudfront:CreateInvalidation"
  ]

  allowed_resources = [
    "arn:aws:s3:::my-portfolio-demo-bucket/*",
    "arn:aws:cloudfront::${var.account_id}:distribution/*"
  ]

  max_session_duration = 3600

  tags = {
    Project = "iam-least-privilege"
    Example = "cicd-deploy"
  }
}
