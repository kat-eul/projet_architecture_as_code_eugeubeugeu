variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc-default-id" {
  type    = string
  default = "vpc-0fd4f7b304caefa43"
}

variable "ami_id" {
  type        = string
  default     = "ami-0f8a61b66d1accaee"
}

variable "key_name" {
  type        = string
  default     = "vockey"
}