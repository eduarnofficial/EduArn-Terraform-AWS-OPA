package terraform.s3

deny contains msg if {

  resource := input.resource_changes[_]

  resource.type == "aws_s3_bucket"

  bucket := resource.change.after.bucket

  not regex.match(
      "^company-(dev|test|stage|prod)-[a-z0-9-]{3,40}$",
      bucket
  )

  msg := sprintf(
      "Bucket '%s' must match pattern company-(dev|test|stage|prod)-<name>",
      [bucket]
  )
}
