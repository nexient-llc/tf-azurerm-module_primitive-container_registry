locals {
    default_tags = {
        provisioner = "terraform"
    }
    tags = merge(local.default_tags, var.container_registry.custom_tags)
}