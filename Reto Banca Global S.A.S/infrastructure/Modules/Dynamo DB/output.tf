output "dynamodb_tables" {
  description = "Map of DynamoDB tables details"
  value = {
    for idx, table in aws_dynamodb_table.dynamo_table : var.dynamo_config[idx].name => {
      id           = table.id
      arn          = table.arn
      stream_arn   = table.stream_arn
      stream_label = table.stream_label
    }
  }
}