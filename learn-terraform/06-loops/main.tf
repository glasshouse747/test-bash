resource "null_resource" "test" {
  count = 10
}

# Count resource attributes are referred with resourcelabel.locallabel[*]
# (* denoting all values, if we want first value then [0])

# output "test" {
#   value = null_resource.test
# }

output "test" {
  value = null_resource.test[*].id
}

resource "null_resource" "testx" {
}

output "testx" {
  value = null_resource.testx.id
}
