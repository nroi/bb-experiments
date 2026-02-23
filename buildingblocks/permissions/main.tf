terraform {
  required_providers {
    meshstack = {
      source  = "meshcloud/meshstack"
      version = ">= 0.17.4"
    }
  }
}

provider "meshstack" {

}

variable "project_identifier" {
  type        = string
  description = "The identifier of the meshStack project to be created."
}

variable "location_identifier" {
  type        = string
  description = "The identifier of the meshStack location to be created."
}

variable "project_tags" {
  type        = map(list(string))
  description = "The tag value for the project's environment"
}

variable "workspace_identifier" {
  type        = string
  description = "The identifier of the existing meshStack workspace."
}

variable "paymentmethod_identifier" {
  type        = string
  description = "The identifier of the existing meshStack payment method."
}

resource "meshstack_project" "this" {
  metadata = {
    name               = var.project_identifier
    owned_by_workspace = var.workspace_identifier
  }
  spec = {
    payment_method_identifier = var.paymentmethod_identifier
    display_name              = "My Project ${var.project_identifier}"
    tags                      = var.project_tags
  }
}

resource "meshstack_tenant" "this" {
  metadata = {
    owned_by_workspace  = meshstack_project.this.metadata.owned_by_workspace
    owned_by_project    = meshstack_project.this.metadata.name
    platform_identifier = "sr.global"
  }

  spec = {
    # landing_zone_identifier is optional for SERVICEREGISTRY platform type
  }
}

resource "meshstack_location" "this" {
  metadata = {
    name = var.location_identifier
    owned_by_workspace  = meshstack_project.this.metadata.owned_by_workspace
  }

  spec = {
    display_name = var.location_identifier
    description  = var.location_identifier
  }
}

