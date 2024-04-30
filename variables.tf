variable "location" {
  type        = string
  description = "The location in which the deployment is happening"
  default     = "uksouth"
}

variable "loc" {
  type        = string
  description = "The location in which the deployment is happening - short form"
  default     = "uks"
}

variable "ident" {
  type        = string
  description = "The project identifier for resources"
  default     = "appcnf"
}

variable "secret_value" {
  type        = string
  description = "The value of the secret"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days to retain soft deleted keys"
  default     = 7
}