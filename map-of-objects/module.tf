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

variable "azure_provider_config" {
  type = map(object(
    {
      client_id = string
      tenant_id = string
    }
    )
  )
  description = "the azure provider config"
}

resource "null_resource" "example" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "echo 'This is a test!'"
  }
}
