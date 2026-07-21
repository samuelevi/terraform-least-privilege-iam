module "lambda_dynamodb_role" {
  source = "../../modules/iam-role"

  role_name = "lambda-orders-table-role"

  trust_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  allowed_actions = [
    "dynamodb:GetItem",
    "dynamodb:PutItem",
    "dynamodb:UpdateItem",
    "dynamodb:Query"
  ]

  allowed_resources = [
    "arn:aws:dynamodb:${var.aws_region}:${var.account_id}:table/orders"
  ]

  max_session_duration = 3600

  tags = {
    Project = "iam-least-privilege"
    Example = "lambda-dynamodb"
  }
}