# A group of resources to be created once is called as module. Equivalent to function in shell. Role in ansible.

# https://developer.hashicorp.com/terraform/language/modules/sources

module "sample1" {
  source = "./sample"

}