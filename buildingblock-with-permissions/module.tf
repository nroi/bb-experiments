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

variable "project_tag_environment" {
  type        = string
  description = "The tag value for the project's environment"
}

variable "project_tag_confidentiality" {
  type        = string
  description = "The tag value for the project's confidentiality"
}

variable "workspace_identifier" {
  type        = string
  description = "The identifier of the existing meshStack workspace."
}

variable "paymentmethod_identifier" {
  type        = string
  description = "The identifier of the existing meshStack payment method."
}

resource "meshstack_project" "example" {
  metadata = {
    name               = var.project_identifier
    owned_by_workspace = var.workspace_identifier
  }
  spec = {
    payment_method_identifier = var.paymentmethod_identifier
    display_name              = "My Project ${var.project_identifier}"
    tags = {
      environment     = [var.project_tag_environment]
      confidentiality = [var.project_tag_confidentiality]
    }
  }
}

resource "meshstack_tenant" "sr_global" {
  metadata = {
    owned_by_workspace  = meshstack_project.example.metadata.owned_by_workspace
    owned_by_project    = meshstack_project.example.metadata.name
    platform_identifier = "sr.global"
  }

  spec = {
    # landing_zone_identifier is optional for SERVICEREGISTRY platform type
  }
}
