variable "text" {
  type = string
  default = "foo"
}

output "text" {
  value = var.text
}
