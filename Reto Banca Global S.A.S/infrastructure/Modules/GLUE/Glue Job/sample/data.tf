data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "nombre_bucket" {
  bucket = "pragma-hefesto-dev-glue-destino"
}