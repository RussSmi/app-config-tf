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

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "sku_name" {
  type        = string
  description = "The SKU name of the Key Vault"
  default     = "premium"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days to retain soft deleted keys"
  default     = 7

}

variable "secret_value" {
  type        = string
  description = "The value of the secret"
}

