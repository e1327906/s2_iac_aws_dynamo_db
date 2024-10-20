variable "hash_key_name" {
  description = "The name of the hash key attribute"
  type        = string
}

variable "range_key_name" {
  description = "The name of the range key attribute (optional)"
  type        = string
  default     = "" # Set a default if optional
}

variable "read_capacity" {
  description = "Read capacity units for the DynamoDB table"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Write capacity units for the DynamoDB table"
  type        = number
  default     = 5
}

variable "index_hash_key" {
  description = "The name of the hash key attribute for the global secondary index"
  type        = string
}

variable "index_read_capacity" {
  description = "Read capacity units for the global secondary index"
  type        = number
  default     = 5
}

variable "index_write_capacity" {
  description = "Write capacity units for the global secondary index"
  type        = number
  default     = 5
}