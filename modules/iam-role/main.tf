resource "aws_iam_role" "this" {
   name = var.role_name
   assume_role_policy = var.trust_policy_json
   max_session_duration = var.max_session_duration
   tags = var.tags
}

data "aws_iam_policy_document" "scoped" {
   statement {
      sid = "ScopedLeastPrivilegeAccess"
      effect = "Allow"
      actions = var.allowed_actions
      resources = var.allowed_resources
   }
}

resource "aws_iam_role_policy" "this" {
   name = "${var.role_name}-scoped-policy"
   role = aws_iam_role.this.id
   policy = data.aws_iam_policy_document.scoped.json
}