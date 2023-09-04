locals {
  module_tags = {
    LastUpdated = formatdate("DD-MM-YYYY:hh:mm", timestamp())
    ManagedBy   = "Terraform"
    Contact     = "help@libredevops.org"
  }

  tags = merge(local.module_tags, var.tags)
}
