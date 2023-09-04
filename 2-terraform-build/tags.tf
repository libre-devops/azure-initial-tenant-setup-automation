locals {
  module_tags = {
    "LastUpdated" = formatdate("DD-MM-YYYY:hh:mm", timestamp())
    "Environment" = "${terraform.workspace}"
  }

  tags = merge(local.module_tags, var.tags)
}


variable "tags" {
  type        = map(string)
  description = "The tags variable"
  default = {
    "CostCentre" = "671888"
    "ManagedBy"  = "Terraform"
    "Contact"    = "help@libredevops.org"
  }
}

output "tags" {
  value = local.tags
}
