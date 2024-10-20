output "table_name" {
  value = aws_dynamodb_table.feedback_demo.name
}

output "table_arn" {
  value = aws_dynamodb_table.feedback_demo.arn
}

output "table_id" {
  value = aws_dynamodb_table.feedback_demo.id
}

output "role_arn" {
  value = aws_iam_role.dynamodb_role.arn
}