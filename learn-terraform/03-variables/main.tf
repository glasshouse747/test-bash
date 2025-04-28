variable "x" {
  default = 10
}

output "x" {
  value = var.x
}

## Variable Dta Types
# string
# number
# boolean
# string require double quotes, number and boolean does not require quotes

variable "str" {
  default = "Hello"
}

variable "num" {
  default = 20
}

variable "mybool" {
  default = true
}


# When we access the variable, irrespective of type you can access it with var.var-name. Also need to access that with ${var.ver-name)

output "str" {
  value ="${var.str}, Steve"
}

## Variable Types

# Normal
# List
# Map/Dictionary

variable "a" {
  default = "This is a normal Variable"
}

# The values in a list can comprise of multiple data types

variable "b" {
  default = [
    1,
    2,
    "abc",
    false
  ]
}

variable "c" {
  default = {
    x = 10
    y = 20
    z = "abc"
  }
}

output "b1" {
  value = var.b[0]
}

output "c1" {
  value = var.c["x"]
}

## Variable from command line
# variable "cli" {} (to change default via cli use -var cli=var

variable "cli" {
  default = 100
}

output "command-line-variable" {
  value = var.cli
}

## Variable from terraform.tfvars
variable "v1" {}

  output "v1" {
    value = var.v1
  }
variable "env" {}
output "env" {
  value = "var.env"
}