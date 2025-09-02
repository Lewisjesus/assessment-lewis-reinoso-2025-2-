resource "aws_dynamodb_table" "dynamo_table" {
  count                       = length(var.dynamo_config) > 0 ? length(var.dynamo_config) : 0
  name                        = join("-", [var.project, var.domain, "dynamo", var.environment, var.dynamo_config[count.index].name, tostring(count.index + 1)])
  billing_mode                = var.dynamo_config[count.index].billing_mode
  read_capacity               = var.dynamo_config[count.index].read_capacity
  write_capacity              = var.dynamo_config[count.index].write_capacity
  hash_key                    = var.dynamo_config[count.index].hash_key
  range_key                   = var.dynamo_config[count.index].range_key
  deletion_protection_enabled = var.dynamo_config[count.index].deletion_protection_enabled

  dynamic "attribute" {
    for_each = var.dynamo_config[count.index].attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.dynamo_config[count.index].global_secondary_indexes
    content {
      name               = global_secondary_index.value["name"]
      hash_key           = global_secondary_index.value["hash_key"]
      range_key          = global_secondary_index.value["range_key"]
      projection_type    = global_secondary_index.value["projection_type"]
      read_capacity      = global_secondary_index.value["read_capacity"]
      write_capacity     = global_secondary_index.value["write_capacity"]
    }
  }

  dynamic "server_side_encryption" {
    for_each = var.dynamo_config[count.index].server_side_encryption
    content {
      enabled     = server_side_encryption.value["enabled"]
      kms_key_arn = server_side_encryption.value["kms_key_arn"]
    }
  }

  dynamic "replica" {
    for_each = var.dynamo_config[count.index].replicas
    content {
      kms_key_arn            = replica.value["kms_key_arn"]
      point_in_time_recovery = replica.value["point_in_time_recovery"]
      propagate_tags         = replica.value["propagate_tags"]
      region_name           = replica.value["region_name"]
    }
  }
  point_in_time_recovery {
    enabled = var.dynamo_config[count.index].point_in_time_recovery
  }

  tags = merge({ Name = join("-", [var.project, var.domain, "dynamo", var.environment, var.dynamo_config[count.index].name, tostring(count.index + 1)]) })
  
}