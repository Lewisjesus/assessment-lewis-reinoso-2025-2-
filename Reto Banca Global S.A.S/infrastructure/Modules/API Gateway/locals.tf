locals {
  # Flatten resources for easier iteration
  flattened_resources = flatten([
    for api in var.api_gateway_config : [
      for resource in api.resources : {
        api_name  = api.name
        path_part = resource.path_part
        path      = resource.path
        parent_id = resource.parent_id
      }
    ]
  ])

  # Flatten methods for easier iteration
  flattened_methods = flatten([
    for api in var.api_gateway_config : [
      for resource in api.resources : [
        for method in resource.methods : {
          api_name           = api.name
          resource_path      = resource.path
          http_method        = method.http_method
          authorization      = method.authorization
          request_parameters = method.request_parameters
          integration        = method.integration
        }
      ]
    ]
  ])

  # Flatten responses for easier iteration
  flattened_responses = flatten([
    for api in var.api_gateway_config : [
      for resource in api.resources : [
        for method in resource.methods : [
          for response in method.responses : {
            api_name                       = api.name
            resource_path                  = resource.path
            http_method                    = method.http_method
            status_code                    = response.status_code
            response_models                = response.response_models
            response_parameters            = response.response_parameters
            integration_response_templates = response.integration_response_templates
          }
        ]
      ]
    ]
  ])

  # Patrones regex solo para niveles 4+
  advanced_level_patterns = {
    3 = "^[^/]+/[^/]+/[^/]+$"                         # Dos barras: v1/price/notes
    4 = "^[^/]+/[^/]+/[^/]+/[^/]+$"                   # Cuatro segmentos: v1/price/notes/{id}
    5 = "^[^/]+/[^/]+/[^/]+/[^/]+/[^/]+$"             # Cinco segmentos: v1/price/notes/{id}/associateMaterials
    6 = "^[^/]+/[^/]+/[^/]+/[^/]+/[^/]+/[^/]+$"       # Seis segmentos: nivel 6
    7 = "^[^/]+/[^/]+/[^/]+/[^/]+/[^/]+/[^/]+/[^/]+$" # Siete segmentos: nivel 7
  }


}
