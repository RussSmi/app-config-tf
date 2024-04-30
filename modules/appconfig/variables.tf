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

variable "kv_id" {
  type        = string
  description = "The keyvault id"
}

variable "kv_secret_ref" {
  type        = string
  description = "The identifier for the Key Vault secret"
}
variable "kv_msi_id" {
  type        = string
  description = "The ID of the managed identity"
}
variable "kv_msi_client_id" {
  type        = string
  description = "The client ID of the managed identity"
}

variable "kv_key_id" {
  type        = string
  description = "The keyvault key id"

}
