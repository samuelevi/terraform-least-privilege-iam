module "s3_readonly_role" {
   source = "../../modules/iam-role"

   role_name = "s3-readonly-role"

   trust_policy_json = jsonencode({
      Version = "2012-10-17"
      Statement = [{
         Effect = "Allow"
         Principal = {
            AWS = "arn:aws:iam::${var.account_id}:root"
         }
         Action = "sts:AssumeRole"
      }]
   })

   allowed_actions = [
      "s3:GetObject",
      "s3:ListBucket"
   ]

   allowed_resources = [
      "arn:aws:s3:::my-portfolio-demo-bucket",
      "arn:aws:s3:::my-portfolio-demo-bucket/*"
   ]

   max_session_duration = 3600

   tags = {
      Project = "iam-least-privilege"
      Example = "s3-readonly"
   }
}