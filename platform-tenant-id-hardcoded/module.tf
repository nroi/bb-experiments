terraform {
  required_providers {
    meshstack = {
      source  = "meshcloud/meshstack"
      version = ">= 0.17.0"
    }
  }
}

provider "meshstack" {
}

output "platform_tenant_id" {
  value = "c6053a20-6941-40ab-aaac-1216dec120c6"
}
