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

variable "ghspid" {
  type        = string
  description = "The principal id of the GitHub service principal"
  default     = "dc9d8e7e-28b4-4c3a-bd23-3b5568670aa5"
}

variable "additoinalSpId" {
  type        = string
  description = "The principal id of the additional service principal"
  default     = "7f36b222-2faa-490a-85d2-77f2ee8000a3"
}

variable "instance" {
  type        = string
  description = "Instance no"
  default     = "004"
}
