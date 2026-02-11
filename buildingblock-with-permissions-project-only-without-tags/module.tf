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

variable "project_identifier" {
  type        = string
  description = "The identifier of the meshStack project to be created."
}

variable "workspace_identifier" {
  type        = string
  description = "The identifier of the meshStack workspace."
}

variable "paymentmethod_identifier" {
  type        = string
  description = "The identifier of the meshStack payment method."
}

resource "meshstack_project" "example" {
  metadata = {
    name               = var.project_identifier
    owned_by_workspace = var.workspace_identifier
  }
  spec = {
    payment_method_identifier = var.paymentmethod_identifier
    display_name              = "My Project ${var.project_identifier}"
  }
}

output "project_created_on" {
  value = meshstack_project.example.metadata.created_on
}
