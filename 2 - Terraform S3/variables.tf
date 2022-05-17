variable "my_access_key" {
  description = "Access-key-for-AWS"
  default = "no_access_key_value_found"
}

variable "my_secret_key" {
  description = "Secret-key-for-AWS"
  default = "no_secret_key_value_found"
}

variable "region" {
  default = "us-east-2" #servidor OHIO
}

variable "bucket_prefix" {
    type        = string
    default     = "test-s3bucket-"
}
variable "tags" {
    type        = map
    default     = {
        environment = "DEV"
        terraform   = "true"
    }
}
variable "versioning" {
    type        = bool
    default     = true
}
variable "acl" {
    type        = string
    default     = "private"
}