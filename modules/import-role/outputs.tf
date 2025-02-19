output "import_role" {
  description = "The IAM role to allow Lucid to do AWS imports"
  value = {
    id   = aws_iam_role.import_role.id
    arn  = aws_iam_role.import_role.arn
    name = aws_iam_role.import_role.name
  }
}
