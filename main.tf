provider "aws" {
  region = "ap-southeast-1"
}

# Define the IAM policy for DynamoDB access
resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "DynamoDBAccessPolicy"
  description = "Allows full access to all DynamoDB tables"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ],
        Resource = "arn:aws:dynamodb:ap-southeast-1:*:table/*"
      }
    ]
  })
}

# Create an IAM role
resource "aws_iam_role" "dynamodb_role" {
  name = "DynamoDBAccessRole"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com" # Adjust based on your use case, e.g., lambda.amazonaws.com
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
  role       = aws_iam_role.dynamodb_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

# Create a DynamoDB table named 'feedback_demo'
resource "aws_dynamodb_table" "feedback_demo" {
  name           = "feedback_demo"
  billing_mode   = "PROVISIONED" # Can be "PAY_PER_REQUEST" if preferred
  hash_key       = var.hash_key_name
  range_key      = var.range_key_name # Optional, omit if not using a range key
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = var.hash_key_name
    type = "S" # Use "N" for number or "B" for binary
  }

  # Optional range key
  attribute {
    name = var.range_key_name
    type = "S"
  }

  global_secondary_index {
    name               = "example-index"
    hash_key           = var.index_hash_key
    projection_type    = "ALL"
    read_capacity      = var.index_read_capacity
    write_capacity     = var.index_write_capacity
  }

  # Include attributes used in the global secondary index
  attribute {
    name = var.index_hash_key
    type = "S"
  }

  tags = {
    Name = "feedback_demo"
  }
}