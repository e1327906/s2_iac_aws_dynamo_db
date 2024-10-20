output "table_name" {
  value = aws_dynamodb_table.feedback.name
}

output "table_arn" {
  value = aws_dynamodb_table.feedback.arn
}

output "table_id" {
  value = aws_dynamodb_table.feedback.id
}

output "role_arn" {
  value = aws_iam_role.dynamodb_role.arn
}