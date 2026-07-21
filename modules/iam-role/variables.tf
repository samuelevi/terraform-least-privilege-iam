variable "role_name" {
  description = "The name of the IAM role."
  type        = string
}

variable "trust_policy_json" {
  description = "JSON-encoded assume-role (trust) policy document - who/what can assume this role."
  type        = string
}

variable "allowed_actions" {
  description = "List of aspecific IAM actions this role is permitted to perform. Never use \"*\"."
  type        = list(string)

   validation {
    condition     = !contains(var.allowed_actions, "*")
    error_message = "Wildcard action \"*\"is not allowed. List specific actions only."
   }
}

variable "allowed_resources" {
   description = "List of specific resource ARNs this role's policy applies to. Never use \"*\"."
   type        = list(string)
   
    validation {
      condition     = !contains(var.allowed_resources, "*")
      error_message = "Wildcard resource \"*\"is not allowed. Scope to specific ARNs."
    }
}

variable "max_session_duration" {
   description = "Max session duration in seconds (default 1 hour)"
   type = number
   default = 3600
}

variable "tags" {
   description = "Tags applied to the role"
   type = map(string)
   default = {}
}