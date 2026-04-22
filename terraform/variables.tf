variable "name" {
  type        = string
}
variable "vpc_id" {
}
variable "subnets_ids" {
}
variable "tags" {
  type        = map(string)
}
variable "region" {
  description = "aws region"
  default     = "eu-central-1"
  type        = string
}

### Backend vars
variable "iam_profile" {
  description = "Profile of aws creds"
  default     = null
  type        = string
}

variable "zone_name" {
  type        = string
}
