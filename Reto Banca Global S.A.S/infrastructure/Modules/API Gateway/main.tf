resource "aws_api_gateway_rest_api" "api" {
  for_each = { for api in var.api_gateway_config : api.name => api }

  name        = join("-", tolist([var.project, var.domain, var.environment, "api", each.value.name]))
  description = each.value.description

  endpoint_configuration {
    types = each.value.endpoint_types
  }

  tags = merge(
    { Name = join("-", tolist([var.project, var.domain, var.environment, "api", each.value.name])) },
    var.resource_tags
  )
}

# Recursos de primer nivel (v1)
resource "aws_api_gateway_resource" "first_level_resources" {
  for_each = {
    for resource in local.flattened_resources :
    "${resource.api_name}.${resource.path}" => resource
    if resource.parent_id == "root"
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id
  parent_id   = aws_api_gateway_rest_api.api[each.value.api_name].root_resource_id
  path_part   = each.value.path_part

  # Prevenir errores si el recurso ya existe
  lifecycle {
    ignore_changes = [path_part]
  }
}

# Recursos de segundo nivel (v1/authentication, v1/organization)
resource "aws_api_gateway_resource" "second_level_resources" {
  for_each = {
    for resource in local.flattened_resources :
    "${resource.api_name}.${resource.path}" => resource
    if resource.parent_id == "v1"
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id
  parent_id   = aws_api_gateway_resource.first_level_resources["${each.value.api_name}.${each.value.parent_id}"].id
  path_part   = each.value.path_part

  # Prevenir errores si el recurso ya existe
  lifecycle {
    ignore_changes = [path_part]
  }
}

# Recursos de tercer nivel (v1/authentication/login, v1/authentication/refresh-token, etc.)
resource "aws_api_gateway_resource" "third_level_resources" {
  # for_each = {
  #   for resource in local.flattened_resources :
  #   "${resource.api_name}.${resource.path}" => resource
  #   if resource.parent_id != "root" && resource.parent_id != "v1" && resource.parent_id != null
  # }
  for_each = {
    for resource in local.flattened_resources :
    "${resource.api_name}.${resource.path}" => resource
    if can(regex(local.advanced_level_patterns[3], resource.path))
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id
  parent_id   = aws_api_gateway_resource.second_level_resources["${each.value.api_name}.${each.value.parent_id}"].id
  path_part   = each.value.path_part

  # Prevenir errores si el recurso ya existe
  lifecycle {
    ignore_changes = [path_part]
  }
}

# Recursos de cuarto nivel (v1/authentication/login, v1/authentication/refresh-token/{id},  etc.)
resource "aws_api_gateway_resource" "fourth_level_resources" {
  for_each = {
    for resource in local.flattened_resources :
    "${resource.api_name}.${resource.path}" => resource
    if can(regex(local.advanced_level_patterns[4], resource.path))
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id
  parent_id   = aws_api_gateway_resource.third_level_resources["${each.value.api_name}.${each.value.parent_id}"].id
  path_part   = each.value.path_part

  # Prevenir errores si el recurso ya existe
  lifecycle {
    ignore_changes = [path_part]
  }
}

# Recursos de quinto nivel (v1/authentication/login, v1/authentication/refresh-token/{id}/associateMaterials,  etc.)
resource "aws_api_gateway_resource" "fifth_level_resources" {
  for_each = {
    for resource in local.flattened_resources :
    "${resource.api_name}.${resource.path}" => resource
    if can(regex(local.advanced_level_patterns[5], resource.path))
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id
  parent_id   = aws_api_gateway_resource.fourth_level_resources["${each.value.api_name}.${each.value.parent_id}"].id
  path_part   = each.value.path_part

  # Prevenir errores si el recurso ya existe
  lifecycle {
    ignore_changes = [path_part]
  }
}

# Recursos de sexto nivel (v1/authentication/login, v1/authentication/refresh-token/{id}/associateMaterials/etc,  etc.)
resource "aws_api_gateway_resource" "sixth_level_resources" {
  for_each = {
    for resource in local.flattened_resources :
    "${resource.api_name}.${resource.path}" => resource
    if can(regex(local.advanced_level_patterns[6], resource.path))
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id
  parent_id   = aws_api_gateway_resource.fifth_level_resources["${each.value.api_name}.${each.value.parent_id}"].id
  path_part   = each.value.path_part

  # Prevenir errores si el recurso ya existe
  lifecycle {
    ignore_changes = [path_part]
  }
}

# Recursos de septimo nivel (v1/authentication/login, v1/authentication/refresh-token/{id}/associateMaterials/etc/etc)
resource "aws_api_gateway_resource" "seventh_level_resources" {
  for_each = {
    for resource in local.flattened_resources :
    "${resource.api_name}.${resource.path}" => resource
    if can(regex(local.advanced_level_patterns[7], resource.path))
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id
  parent_id   = aws_api_gateway_resource.sixth_level_resources["${each.value.api_name}.${each.value.parent_id}"].id
  path_part   = each.value.path_part

  # Prevenir errores si el recurso ya existe
  lifecycle {
    ignore_changes = [path_part]
  }
}

# Autorizador Lambda
resource "aws_api_gateway_authorizer" "lambda" {
  for_each = { for api in var.api_gateway_config : api.name => api }

  name                             = "${each.value.name}-lambda-authorizer"
  rest_api_id                      = aws_api_gateway_rest_api.api[each.key].id
  type                             = "REQUEST"
  authorizer_uri                   = var.lambda_authorizer_invoke_arn
  identity_source                  = "method.request.header.Authorization"
  authorizer_credentials           = aws_iam_role.api_gateway_authorizer_role.arn
  authorizer_result_ttl_in_seconds = 0 # Caché de resultados por 5 minutos
}

# Rol IAM para que API Gateway invoque la función Lambda autorizadora
resource "aws_iam_role" "api_gateway_authorizer_role" {
  name = "${var.project}-${var.domain}-${var.environment}-apigateway-auth-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })

  tags = var.resource_tags
}

# Política para permitir que API Gateway invoque la función Lambda
resource "aws_iam_role_policy" "api_gateway_authorizer_policy" {
  name = "${var.project}-${var.domain}-${var.environment}-apigateway-auth-policy"
  role = aws_iam_role.api_gateway_authorizer_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "lambda:InvokeFunction"
        Effect   = "Allow"
        Resource = var.lambda_authorizer_arn
      }
    ]
  })
}

# Métodos HTTP
resource "aws_api_gateway_method" "method" {
  for_each = {
    for method in local.flattened_methods :
    "${method.api_name}.${method.resource_path}.${method.http_method}" => method
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id

  # Determinar resource_id basado en el nivel del recurso
  resource_id = try(
    # Para recursos de primer nivel (v1) - LÓGICA ACTUAL
    aws_api_gateway_resource.first_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
    try(
      # Para recursos de segundo nivel - LÓGICA ACTUAL
      aws_api_gateway_resource.second_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
      try(
        # Para recursos de tercer nivel - LÓGICA ACTUAL
        aws_api_gateway_resource.third_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
        try(
          # Para recursos de cuarto nivel - NUEVO CON REGEX
          aws_api_gateway_resource.fourth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
          try(
            # Para recursos de quinto nivel - NUEVO CON REGEX
            aws_api_gateway_resource.fifth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
            try(
              # Para recursos de sexto nivel - NUEVO CON REGEX
              aws_api_gateway_resource.sixth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
              # Para recursos de séptimo nivel - NUEVO CON REGEX
              aws_api_gateway_resource.seventh_level_resources["${each.value.api_name}.${each.value.resource_path}"].id
            )
          )
        )
      )
    )
  )

  http_method        = each.value.http_method
  authorization      = each.value.authorization == "COGNITO_USER_POOLS" ? "CUSTOM" : each.value.authorization
  authorizer_id      = each.value.authorization == "COGNITO_USER_POOLS" ? aws_api_gateway_authorizer.lambda[each.value.api_name].id : null
  request_parameters = each.value.request_parameters
}

# Integraciones
resource "aws_api_gateway_integration" "integration" {
  for_each = {
    for method in local.flattened_methods :
    "${method.api_name}.${method.resource_path}.${method.http_method}" => method
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id

  # Determinar resource_id basado en el nivel del recurso - mismo enfoque que en los métodos
  resource_id = try(
    # Para recursos de primer nivel (v1) - LÓGICA ACTUAL
    aws_api_gateway_resource.first_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
    try(
      # Para recursos de segundo nivel - LÓGICA ACTUAL
      aws_api_gateway_resource.second_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
      try(
        # Para recursos de tercer nivel - LÓGICA ACTUAL
        aws_api_gateway_resource.third_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
        try(
          # Para recursos de cuarto nivel - NUEVO CON REGEX
          aws_api_gateway_resource.fourth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
          try(
            # Para recursos de quinto nivel - NUEVO CON REGEX
            aws_api_gateway_resource.fifth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
            try(
              # Para recursos de sexto nivel - NUEVO CON REGEX
              aws_api_gateway_resource.sixth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
              # Para recursos de séptimo nivel - NUEVO CON REGEX
              aws_api_gateway_resource.seventh_level_resources["${each.value.api_name}.${each.value.resource_path}"].id
            )
          )
        )
      )
    )
  )

  http_method             = aws_api_gateway_method.method[each.key].http_method
  integration_http_method = each.value.integration.integration_http_method
  type                    = each.value.integration.type
  uri                     = each.value.integration.uri
  request_templates       = each.value.integration.request_templates
  request_parameters      = try(each.value.integration.request_parameters, {})
  connection_type         = each.value.integration.connection_type
  connection_id           = each.value.integration.connection_id
  timeout_milliseconds    = each.value.integration.timeout_milliseconds

}

# Respuestas de método
resource "aws_api_gateway_method_response" "response" {
  for_each = {
    for response in local.flattened_responses :
    "${response.api_name}.${response.resource_path}.${response.http_method}.${response.status_code}" => response
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id

  resource_id = try(
    # Para recursos de primer nivel (v1) - LÓGICA ACTUAL
    aws_api_gateway_resource.first_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
    try(
      # Para recursos de segundo nivel - LÓGICA ACTUAL
      aws_api_gateway_resource.second_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
      try(
        # Para recursos de tercer nivel - LÓGICA ACTUAL
        aws_api_gateway_resource.third_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
        try(
          # Para recursos de cuarto nivel - NUEVO CON REGEX
          aws_api_gateway_resource.fourth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
          try(
            # Para recursos de quinto nivel - NUEVO CON REGEX
            aws_api_gateway_resource.fifth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
            try(
              # Para recursos de sexto nivel - NUEVO CON REGEX
              aws_api_gateway_resource.sixth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
              # Para recursos de séptimo nivel - NUEVO CON REGEX
              aws_api_gateway_resource.seventh_level_resources["${each.value.api_name}.${each.value.resource_path}"].id
            )
          )
        )
      )
    )
  )

  http_method = aws_api_gateway_method.method["${each.value.api_name}.${each.value.resource_path}.${each.value.http_method}"].http_method
  status_code = each.value.status_code

  response_models = each.value.response_models
  response_parameters = merge(
    each.value.response_parameters,
    {
      "method.response.header.Strict-Transport-Security" = true,
      "method.response.header.X-Content-Type-Options"    = true,
      "method.response.header.Referrer-Policy"           = true
    }
  )
}

# Respuestas de integración
resource "aws_api_gateway_integration_response" "integration_response" {
  for_each = {
    for response in local.flattened_responses :
    "${response.api_name}.${response.resource_path}.${response.http_method}.${response.status_code}" => response
  }

  rest_api_id = aws_api_gateway_rest_api.api[each.value.api_name].id

  resource_id = try(
    # Para recursos de primer nivel (v1) - LÓGICA ACTUAL
    aws_api_gateway_resource.first_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
    try(
      # Para recursos de segundo nivel - LÓGICA ACTUAL
      aws_api_gateway_resource.second_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
      try(
        # Para recursos de tercer nivel - LÓGICA ACTUAL
        aws_api_gateway_resource.third_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
        try(
          # Para recursos de cuarto nivel - NUEVO CON REGEX
          aws_api_gateway_resource.fourth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
          try(
            # Para recursos de quinto nivel - NUEVO CON REGEX
            aws_api_gateway_resource.fifth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
            try(
              # Para recursos de sexto nivel - NUEVO CON REGEX
              aws_api_gateway_resource.sixth_level_resources["${each.value.api_name}.${each.value.resource_path}"].id,
              # Para recursos de séptimo nivel - NUEVO CON REGEX
              aws_api_gateway_resource.seventh_level_resources["${each.value.api_name}.${each.value.resource_path}"].id
            )
          )
        )
      )
    )
  )

  http_method = aws_api_gateway_method.method["${each.value.api_name}.${each.value.resource_path}.${each.value.http_method}"].http_method
  status_code = aws_api_gateway_method_response.response[each.key].status_code

  response_templates = each.value.integration_response_templates
  response_parameters = merge(
    try(each.value.integration_response_parameters, {}),
    {
      "method.response.header.Strict-Transport-Security" = "'max-age=31536000; includeSubDomains'",
      "method.response.header.X-Content-Type-Options"    = "'nosniff'",
      "method.response.header.Referrer-Policy"           = "'no-referrer'"
    }
  )
}

resource "aws_api_gateway_deployment" "deployment" {
  for_each = { for api in var.api_gateway_config : api.name => api }

  rest_api_id = aws_api_gateway_rest_api.api[each.key].id

  # Añadir un trigger que cambia cada vez que ejecutas terraform apply
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.first_level_resources,
      aws_api_gateway_resource.second_level_resources,
      aws_api_gateway_resource.third_level_resources,
      aws_api_gateway_method.method,
      aws_api_gateway_integration.integration,
      aws_api_gateway_method_response.response,
      aws_api_gateway_integration_response.integration_response,
      aws_api_gateway_authorizer.lambda,
      # Añadir timestamp para forzar actualizaciones manuales
      timestamp()
    ]))
  }

  depends_on = [
    aws_api_gateway_method.method,
    aws_api_gateway_integration.integration,
    aws_api_gateway_method_response.response,
    aws_api_gateway_integration_response.integration_response
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Etapa
resource "aws_api_gateway_stage" "stage" {
  for_each = { for api in var.api_gateway_config : api.name => api }

  deployment_id = aws_api_gateway_deployment.deployment[each.key].id
  rest_api_id   = aws_api_gateway_rest_api.api[each.key].id
  stage_name    = var.environment

  tags = merge(
    { Name = join("-", tolist([var.project, var.domain, var.environment, "stage", each.value.name])) },
    var.resource_tags
  )
}

# Permisos Lambda
resource "aws_lambda_permission" "api_gateway_lambda_invoke" {
  for_each = var.lambda_function_names

  statement_id  = "AllowAPIGateway-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = each.value
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api[var.api_gateway_config[0].name].execution_arn}/*/*"
}

# Permisos para la función de token
resource "aws_lambda_permission" "api_gateway_lambda_token" {
  statement_id  = "AllowAPIGateway-Token"
  action        = "lambda:InvokeFunction"
  function_name = var.token_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api[var.api_gateway_config[0].name].execution_arn}/*/*"
}

# Permisos para la función de refresh token
resource "aws_lambda_permission" "api_gateway_lambda_refresh_token" {
  statement_id  = "AllowAPIGateway-RefreshToken"
  action        = "lambda:InvokeFunction"
  function_name = var.refresh_token_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api[var.api_gateway_config[0].name].execution_arn}/*/*"
}

# Permisos para la Lambda autorizadora
resource "aws_lambda_permission" "api_gateway_lambda_authorizer" {
  statement_id  = "AllowAPIGatewayAuthorizer"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_authorizer_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api[var.api_gateway_config[0].name].execution_arn}/authorizers/*"
}

# Configuración de headers de seguridad para todas las respuestas del API Gateway
resource "aws_api_gateway_gateway_response" "security_headers" {
  for_each = { for api in var.api_gateway_config : api.name => api }

  rest_api_id   = aws_api_gateway_rest_api.api[each.key].id
  response_type = "DEFAULT_4XX"

  response_parameters = {
    "gatewayresponse.header.Strict-Transport-Security" = "'max-age=31536000; includeSubDomains'"
    "gatewayresponse.header.X-Content-Type-Options"    = "'nosniff'"
    "gatewayresponse.header.Referrer-Policy"           = "'no-referrer'"
  }
}

# Configuración de método para throttling y logging
# Etapa
# Configuración de throttling
resource "aws_api_gateway_method_settings" "all_methods_throttling" {
  for_each = { for api in var.api_gateway_config : api.name => api }

  rest_api_id = aws_api_gateway_rest_api.api[each.key].id
  stage_name  = aws_api_gateway_stage.stage[each.key].stage_name
  method_path = "*/*"

  settings {
    throttling_burst_limit = 20
    throttling_rate_limit  = 10
    metrics_enabled        = true
  }
}

resource "aws_api_gateway_gateway_response" "security_headers_5xx" {
  for_each = { for api in var.api_gateway_config : api.name => api }

  rest_api_id   = aws_api_gateway_rest_api.api[each.key].id
  response_type = "DEFAULT_5XX"

  response_parameters = {
    "gatewayresponse.header.Strict-Transport-Security" = "'max-age=31536000; includeSubDomains'"
    "gatewayresponse.header.X-Content-Type-Options"    = "'nosniff'"
    "gatewayresponse.header.Referrer-Policy"           = "'no-referrer'"
  }
}

# VPC Link para API Gateway REST API
resource "aws_api_gateway_vpc_link" "lb_vpc_link" {
  count = var.vpc_link_config.enabled ? 1 : 0

  name        = var.vpc_link_config.name
  target_arns = var.vpc_link_config.target_arns # ARNs del ALB

  tags = merge(
    {
      Name    = var.vpc_link_config.name
      Purpose = "Connect API Gateway to ALB privately"
    },
    var.resource_tags
  )
}
