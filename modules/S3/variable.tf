variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "versioning_status" {
  description = "The versioning status for the S3 bucket"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}