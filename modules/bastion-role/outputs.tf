output "bastion_role" {
  description = "The bastion role to allow read organization access and assume member account import roles"
  value = {
    id   = aws_iam_role.bastion_role.id
    arn  = aws_iam_role.bastion_role.arn
    name = aws_iam_role.bastion_role.name
  }
}
