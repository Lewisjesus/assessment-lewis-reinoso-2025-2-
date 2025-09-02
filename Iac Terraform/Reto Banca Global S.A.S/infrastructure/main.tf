# main.tf
module "vpc" {
  source               = "./Modules/VPC"
  project              = var.project
  environment          = var.environment
  instance_tenancy     = var.instance_tenancy
  cidrblock            = var.cidrblock
  domain               = var.domain
  enable_dns_hostnames = var.enable_dns_hostnames
  vpc_name             = var.vpc_name
  enable_dns_support   = var.enable_dns_support
  subnet_name          = var.subnet_name
  tags                 = var.tags
  id_tgw_db            = var.id_tgw_db
  resource_tags        = var.resource_tags

  endpoints = [
    {
      service_name      = var.endpoint_service_name
      vpc_endpoint_type = var.endpoint_type
      auto_accept       = var.endpoint_auto_accept
      policy            = var.endpoint_policy
      tags              = var.endpoint_tags
    },

    # Impresión de precios - Vpc Endpoints - Secret Manager
    {
      service_name       = var.endpoint_service_name_secretmanager
      vpc_endpoint_type  = var.endpoint_type_secretmanager
      auto_accept        = var.endpoint_auto_accept_secretmanager
      policy             = var.endpoint_policy_secretmanager
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },

    # Impresión de precios - Vpc Endpoints - Api Gateway
    {
      service_name       = var.endpoint_service_name_apigateway
      vpc_endpoint_type  = var.endpoint_type_apigateway
      auto_accept        = var.endpoint_auto_accept_apigateway
      policy             = var.endpoint_policy_apigateway
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },
    # Impresión de precios - Vpc Endpoints - Parameters Store
    {
      service_name       = var.endpoint_service_name_parameter_store
      vpc_endpoint_type  = var.endpoint_type_parameter_store
      auto_accept        = var.endpoint_auto_accept_parameter_store
      policy             = var.endpoint_policy_parameter_store
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },
    # Impresión de precios - Vpc Endpoints - Ecr-api
    {
      service_name       = var.endpoint_service_name_ecr_api
      vpc_endpoint_type  = var.endpoint_type_ecr_api
      auto_accept        = var.endpoint_auto_accept_ecr_api
      policy             = var.endpoint_policy_ecr_api
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },
    # Impresión de precios - Vpc Endpoints - Ecr-Dkr
    {
      service_name       = var.endpoint_service_name_ecr_dkr
      vpc_endpoint_type  = var.endpoint_type_ecr_dkr
      auto_accept        = var.endpoint_auto_accept_ecr_dkr
      policy             = var.endpoint_policy_ecr_dkr
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },
    # Impresión de precios - Vpc Endpoints - Glue
    {
      service_name       = var.endpoint_service_name_glue
      vpc_endpoint_type  = var.endpoint_type_glue
      auto_accept        = var.endpoint_auto_accept_glue
      policy             = var.endpoint_policy_glue
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },
    # Impresión de precios - Vpc Endpoints - CL
    {
      service_name       = var.endpoint_service_name_cloudWatch_logs
      vpc_endpoint_type  = var.endpoint_type_cloudWatch_logs
      auto_accept        = var.endpoint_auto_accept_cloudWatch_logs
      policy             = var.endpoint_policy_cloudWatch_logs
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },
    {
      service_name       = var.endpoint_service_name_ecs
      vpc_endpoint_type  = var.endpoint_type_ecs
      auto_accept        = var.endpoint_auto_accept_ecs
      policy             = var.endpoint_policy_ecs
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },
    {
      service_name       = var.endpoint_service_name_elb
      vpc_endpoint_type  = var.endpoint_type_elb
      auto_accept        = var.endpoint_auto_accept_elb
      policy             = var.endpoint_policy_elb
      subnet_names       = [var.subnet_1a_name_second_project, var.subnet_1b_name_second_project]  # se agrega las subnets para vpc endpoints interfaces
      security_group_ids = [module.security_groups.security_groups["vpc-endpoints-interfaces"].id] #se asocia el sg para vpc endpoints para vpc endpoints interfaces
      tags               = var.endpoint_tags
    },
    {
      service_name      = var.endpoint_service_name_dynamo
      vpc_endpoint_type = var.endpoint_type_dynamo
      auto_accept       = var.endpoint_auto_accept_dynamo
      policy            = var.endpoint_policy_dynamo
      tags              = var.endpoint_tags
    },
  ]

  endpoint_route_table_association_enabled = var.endpoint_route_table_association_enabled

  subnet_config = [
    # Subnet Privada 1 - AZ a
    {
      name              = var.subnet_1a_name
      cidr_block        = var.subnet_1a_cidr
      availability_zone = "${var.aws_region}a"
      private           = var.subnet_1a_private

      route_table_config = {
        routes = [
          {
            cidr_block         = var.route_cidr_block
            transit_gateway_id = var.id_tgw_db
          },
          {
            cidr_block         = var.route_cidr_block_new
            transit_gateway_id = var.id_tgw_db
          },
          {
            cidr_block         = var.route_cidr_block_db
            transit_gateway_id = var.id_tgw_db
          }
        ]
      }

      tags = var.subnet_1a_tags
    },
    # Subnet Privada 2 - AZ b
    {
      name              = var.subnet_1b_name
      cidr_block        = var.subnet_1b_cidr
      availability_zone = "${var.aws_region}b"
      private           = var.subnet_1b_private

      route_table_config = {
        routes = [
          {
            cidr_block         = var.route_cidr_block
            transit_gateway_id = var.id_tgw_db
          },
          {
            cidr_block         = var.route_cidr_block_new
            transit_gateway_id = var.id_tgw_db
          },
          {
            cidr_block         = var.route_cidr_block_db
            transit_gateway_id = var.id_tgw_db
          }
        ]
      }

      tags = var.subnet_1b_tags
    },
    #Subnet Privada 1 - AZ a  -  Impresión de precios 
    {
      name              = var.subnet_1a_name_second_project
      cidr_block        = var.subnet_1a_cidr_second_project
      availability_zone = "${var.aws_region}a"
      private           = var.subnet_1a_private_second_project
      route_table_config = {
        routes = [
          {
            cidr_block         = var.route_cidr_block
            transit_gateway_id = var.id_tgw_db
          },
          {
            cidr_block         = var.route_cidr_block_new
            transit_gateway_id = var.id_tgw_db
          },
          {
            cidr_block         = var.route_cidr_block_db
            transit_gateway_id = var.id_tgw_db
          }
        ]
      }
      tags = var.subnet_1a_tags_second_project
    },
    # Subnet Privada 2 - AZ b - Impresión de precios 
    {
      name              = var.subnet_1b_name_second_project
      cidr_block        = var.subnet_1b_cidr_second_project
      availability_zone = "${var.aws_region}b"
      private           = var.subnet_1b_private_second_project
      route_table_config = {
        routes = [
          {
            cidr_block         = var.route_cidr_block
            transit_gateway_id = var.id_tgw_db
          },
          {
            cidr_block         = var.route_cidr_block_new
            transit_gateway_id = var.id_tgw_db
          },
          {
            cidr_block         = var.route_cidr_block_db
            transit_gateway_id = var.id_tgw_db
          }
        ]
      }
      tags = var.subnet_1b_tags_second_project
    }
  ]
}


module "security_groups" {
  project       = var.project
  domain        = var.domain
  vpc_id        = module.vpc.id
  environment   = var.environment
  resource_tags = var.resource_tags

  source = "./Modules/Security Group"
  sg_config = [
    {
      name        = var.extraction_lambda_sg_name
      description = var.extraction_lambda_sg_description
      ingress_rules = [
        {
          description = var.extraction_lambda_ingress_description
          from_port   = var.extraction_lambda_ingress_from_port
          to_port     = var.extraction_lambda_ingress_to_port
          protocol    = var.extraction_lambda_ingress_protocol
          self        = var.extraction_lambda_ingress_self
          cidr_blocks = var.secretsmanager_vpc_endpoints
        }
      ]
      egress_rules = [
        {
          description = var.extraction_lambda_egress_description
          from_port   = var.extraction_lambda_egress_from_port
          to_port     = var.extraction_lambda_egress_to_port
          protocol    = var.extraction_lambda_egress_protocol
          cidr_blocks = var.dynamodb_vpc_endpoints
        },
        {
          description = var.extraction_lambda_egress_description_https
          from_port   = var.extraction_lambda_egress_from_port_https
          to_port     = var.extraction_lambda_egress_to_port_https
          protocol    = var.extraction_lambda_egress_protocol_https
          cidr_blocks = var.secretsmanager_vpc_endpoints
        },
        {
          description = var.extraction_lambda_egress_acceess_oci
          from_port   = var.extraction_lambda_egress_from_port_acceess_oci
          to_port     = var.extraction_lambda_egress_to_port_acceess_oci
          protocol    = var.extraction_lambda_egress_protocol_acceess_oci
          cidr_blocks = var.oci_endpoints
        }
      ]
    },
    {
      name          = var.comparison_lambda_sg_name
      description   = var.comparison_lambda_sg_description
      ingress_rules = var.comparison_lambda_ingress_rules
      egress_rules = [
        {
          description = var.comparison_lambda_egress_description
          from_port   = var.comparison_lambda_egress_from_port
          to_port     = var.comparison_lambda_egress_to_port
          protocol    = var.comparison_lambda_egress_protocol
          cidr_blocks = var.sqs_vpc_endpoints
        }
      ]
    },
    {
      name          = var.normalization_lambda_sg_name
      description   = var.normalization_lambda_sg_description
      ingress_rules = var.normalization_lambda_ingress_rules
      egress_rules = [
        {
          description = var.normalization_lambda_egress_description
          from_port   = var.normalization_lambda_egress_from_port
          to_port     = var.normalization_lambda_egress_to_port
          protocol    = var.normalization_lambda_egress_protocol
          cidr_blocks = distinct(concat(var.kms_vpc_endpoints, var.s3_vpc_endpoints))
        }
      ]
    },

    # Impresión de precios - Security Group - Glue Jobs
    {
      name        = var.extraction_gluejobs_sg_name
      description = var.extraction_gluejobs_sg_description
      ingress_rules = [
        {
          description = var.extraction_gluejobs_ingress_description
          from_port   = var.extraction_gluejobs_ingress_from_port
          to_port     = var.extraction_gluejobs_ingress_to_port
          protocol    = var.extraction_lambda_ingress_protocol
          self        = var.extraction_gluejobs_ingress_self
          cidr_blocks = var.cidr_blocks_glue_jobs
        }
      ]
      egress_rules = [
        {
          description = var.extraction_gluejobs_egress_description
          from_port   = var.extraction_gluejobs_egress_from_port
          to_port     = var.extraction_gluejobs_egress_to_port
          protocol    = var.extraction_gluejobs_egress_protocol
          cidr_blocks = var.cidr_blocks_glue_jobs
        },
        {
          description = var.extraction_gluejobs_egress_description_pricehistory 
          from_port   = var.extraction_gluejobs_egress_from_port_pricehistory    
          to_port     = var.extraction_gluejobs_egress_to_port_pricehistory    
          protocol    = var.extraction_gluejobs_egress_protocol_pricehistory    
          sg_name     = var.priceHistory-ecs_sg_name                            
        }
      ]
    },

    # Impresión de precios - Security Group - ECS Materials
    {
      name        = var.materials_ecs_sg_name
      description = var.materials_ecs_sg_description
      ingress_rules = [
        {
          description = var.materials_ecs_ingress_description
          from_port   = var.materials_ecs_ingress_from_port
          to_port     = var.materials_ecs_ingress_to_port
          protocol    = var.materials_ecs_ingress_protocol
          self        = var.materials_ecs_ingress_self
          sg_name     = var.price_printing_nlb_sg_name
        },
        {
          description = var.materials_ecs_ingress_description_prices
          from_port   = var.materials_ecs_ingress_from_port_prices
          to_port     = var.materials_ecs_ingress_to_port_prices
          protocol    = var.materials_ecs_ingress_protocol_prices
          self        = var.materials_ecs_ingress_self_prices
          sg_name     = var.prices-ecs_sg_name
        },
        {
          description = var.materials_ecs_ingress_description_notes
          from_port   = var.materials_ecs_ingress_from_port_notes
          to_port     = var.materials_ecs_ingress_to_port_notes
          protocol    = var.materials_ecs_ingress_protocol_notes
          self        = var.materials_ecs_ingress_self_notes
          sg_name     = var.notes-ecs_sg_name
        },
        {
          description = var.materials_ecs_ingress_description_priceshistory
          from_port   = var.materials_ecs_ingress_from_port_priceshistory
          to_port     = var.materials_ecs_ingress_to_port_priceshistory
          protocol    = var.materials_ecs_ingress_protocol_priceshistory
          self        = var.materials_ecs_ingress_self_priceshistory
          sg_name     = var.priceHistory-ecs_sg_name
        }
      ]
      egress_rules = [
        {
          description = var.materials_ecs_egress_description
          from_port   = var.materials_ecs_egress_from_port
          to_port     = var.materials_ecs_egress_to_port
          protocol    = var.materials_ecs_egress_protocol
          cidr_blocks = var.cidr_blocks_ecs
        }
      ]
    },

    # Impresión de precios - Security Group - Vpc Endpoint ecr y ssm
    {
      name        = var.vpc_endpoints_sg_name
      description = var.vpc_endpoints_sg_description
      ingress_rules = [
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.materials_ecs_sg_name
        },
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.extraction_gluejobs_sg_name
        },
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.extraction_lambda_sg_name
        },
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.price_printing_nlb_sg_name
        },
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.notes-ecs_sg_name
        },
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.prices-ecs_sg_name
        },
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.priceTagSegments-ecs_sg_name
        },
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.priceTagRules-ecs_sg_name
        },
        {
          description = var.vpc_endpoints_ingress_description
          from_port   = var.vpc_endpoints_ingress_from_port
          to_port     = var.vpc_endpoints_ingress_to_port
          protocol    = var.vpc_endpoints_ingress_protocol
          self        = var.vpc_endpoints_ingress_self
          sg_name     = var.priceHistory-ecs_sg_name
        }
      ]
      egress_rules = [
        {
          description = var.vpc_endpoints_egress_description
          from_port   = var.vpc_endpoints_egress_from_port
          to_port     = var.vpc_endpoints_egress_to_port
          protocol    = var.vpc_endpoints_egress_protocol
          cidr_blocks = var.cidr_blocks_vpc_endpoints
        }
      ]
    },

    # Impresión de precios - Security Group - ECS Notes
    {
      name        = var.notes-ecs_sg_name
      description = var.notes-ecs_sg_description
      ingress_rules = [
        {
          description = var.notes-ecs_ingress_description
          from_port   = var.notes-ecs_ingress_from_port
          to_port     = var.notes-ecs_ingress_to_port
          protocol    = var.notes-ecs_ingress_protocol
          self        = var.notes-ecs_ingress_self
          sg_name     = var.price_printing_nlb_sg_name
        },
        {
          description = var.notes_ecs_ingress_description_prices
          from_port   = var.notes_ecs_ingress_from_port_prices
          to_port     = var.notes_ecs_ingress_to_port_prices
          protocol    = var.notes_ecs_ingress_protocol_prices
          self        = var.notes_ecs_ingress_self_prices
          sg_name     = var.prices-ecs_sg_name
        },
        {
          description = var.notes_ecs_ingress_description_priceshistory
          from_port   = var.notes_ecs_ingress_from_port_priceshistory
          to_port     = var.notes_ecs_ingress_to_port_priceshistory
          protocol    = var.notes_ecs_ingress_protocol_priceshistory
          self        = var.notes_ecs_ingress_self_priceshistory
          sg_name     = var.priceHistory-ecs_sg_name
        }
      ]
      egress_rules = [
        {
          description = var.notes-ecs_egress_description
          from_port   = var.notes-ecs_egress_from_port
          to_port     = var.notes-ecs_egress_to_port
          protocol    = var.notes-ecs_egress_protocol
          sg_name     = var.materials_ecs_sg_name
        },
        {
          description = var.notes_ecs_egress_description_nlb
          from_port   = var.notes_ecs_egress_from_port_nlb
          to_port     = var.notes_ecs_egress_to_port_nlb
          protocol    = var.notes_ecs_egress_protocol_nlb
          cidr_blocks = var.cidr_blocks_ecs
        }
      ]
    },
    # Impresión de precios - Security Group - ECS Prices
    {
      name        = var.prices-ecs_sg_name
      description = var.prices-ecs_sg_description
      ingress_rules = [
        {
          description = var.prices-ecs_ingress_description
          from_port   = var.prices-ecs_ingress_from_port
          to_port     = var.prices-ecs_ingress_to_port
          protocol    = var.prices-ecs_ingress_protocol
          self        = var.prices-ecs_ingress_self
          sg_name     = var.price_printing_nlb_sg_name
        }
      ]
      egress_rules = [
        {
          description = var.prices-ecs_egress_description
          from_port   = var.prices-ecs_egress_from_port
          to_port     = var.prices-ecs_egress_to_port
          protocol    = var.prices-ecs_egress_protocol
          cidr_blocks = var.cidr_blocks_ecs
        },
        {
          description = var.prices_ecs_egress_description_materials
          from_port   = var.prices_ecs_egress_from_port_materials
          to_port     = var.prices_ecs_egress_to_port_materials
          protocol    = var.prices_ecs_egress_protocol_materials
          sg_name     = var.materials_ecs_sg_name
        },
        {
          description = var.prices_ecs_egress_description_notes
          from_port   = var.prices_ecs_egress_from_port_notes
          to_port     = var.prices_ecs_egress_to_port_notes
          protocol    = var.prices_ecs_egress_protocol_notes
          sg_name     = var.notes-ecs_sg_name
        },
        {
          description = var.prices_ecs_egress_description_segments
          from_port   = var.prices_ecs_egress_from_port_segments
          to_port     = var.prices_ecs_egress_to_port_segments
          protocol    = var.prices_ecs_egress_protocol_segments
          sg_name     = var.priceTagSegments-ecs_sg_name
        },
        {
          description = var.prices_ecs_egress_description_rules
          from_port   = var.prices_ecs_egress_from_port_rules
          to_port     = var.prices_ecs_egress_to_port_rules
          protocol    = var.prices_ecs_egress_protocol_rules
          sg_name     = var.priceTagRules-ecs_sg_name
        }
      ]
    },
    # Impresión de precios - Security Group - NLB 
    {
      name        = var.price_printing_nlb_sg_name
      description = var.price_printing_nlb_sg_description
      ingress_rules = [
        {
          description = var.price_printing_nlb_ingress_description
          from_port   = var.price_printing_nlb_ingress_from_port
          to_port     = var.price_printing_nlb_ingress_to_port
          protocol    = var.price_printing_nlb_ingress_protocol
          self        = var.price_printing_nlb_ingress_self
          cidr_blocks = var.cidr_blocks_glue_jobs
        }
      ]
      egress_rules = [
        {
          description = var.price_printing_nlb_egress_description
          from_port   = var.price_printing_nlb_egress_from_port
          to_port     = var.price_printing_nlb_egress_to_port
          protocol    = var.price_printing_nlb_egress_protocol
          cidr_blocks = var.cidr_blocks_ecs
        }
      ]
    },
    # Impresión de precios - Security Group - ECS priceTagSegments
    {
      name        = var.priceTagSegments-ecs_sg_name
      description = var.priceTagSegments-ecs_sg_description
      ingress_rules = [
        {
          description = var.priceTagSegments-ecs_ingress_description
          from_port   = var.priceTagSegments-ecs_ingress_from_port
          to_port     = var.priceTagSegments-ecs_ingress_to_port
          protocol    = var.priceTagSegments-ecs_ingress_protocol
          self        = var.priceTagSegments-ecs_ingress_self
          sg_name     = var.price_printing_nlb_sg_name
        },
        {
          description = var.priceTagSegments_ecs_ingress_description_prices
          from_port   = var.priceTagSegments_ecs_ingress_from_port_prices
          to_port     = var.priceTagSegments_ecs_ingress_to_port_prices
          protocol    = var.priceTagSegments_ecs_ingress_protocol_prices
          self        = var.priceTagSegments_ecs_ingress_self_prices
          sg_name     = var.prices-ecs_sg_name
        },
        {
          description = var.priceTagSegments_ecs_ingress_description_priceshistory
          from_port   = var.priceTagSegments_ecs_ingress_from_port_priceshistory
          to_port     = var.priceTagSegments_ecs_ingress_to_port_priceshistory
          protocol    = var.priceTagSegments_ecs_ingress_protocol_priceshistory
          self        = var.priceTagSegments_ecs_ingress_self_priceshistory
          sg_name     = var.priceHistory-ecs_sg_name
        }
      ]
      egress_rules = [
        {
          description = var.priceTagSegments-ecs_egress_description
          from_port   = var.priceTagSegments-ecs_egress_from_port
          to_port     = var.priceTagSegments-ecs_egress_to_port
          protocol    = var.priceTagSegments-ecs_egress_protocol
          sg_name     = var.priceTagRules-ecs_sg_name
        },
        {
          description = var.priceTagSegments_ecs_egress_description_nlb
          from_port   = var.priceTagSegments_ecs_egress_from_port_nlb
          to_port     = var.priceTagSegments_ecs_egress_to_port_nlb
          protocol    = var.priceTagSegments_ecs_egress_protocol_nlb
          cidr_blocks = var.cidr_blocks_ecs
        }
      ]
    },
    # Impresión de precios - Security Group - ECS priceTagRules
    {
      name        = var.priceTagRules-ecs_sg_name
      description = var.priceTagRules-ecs_sg_description
      ingress_rules = [
        {
          description = var.priceTagRules-ecs_ingress_description
          from_port   = var.priceTagRules-ecs_ingress_from_port
          to_port     = var.priceTagRules-ecs_ingress_to_port
          protocol    = var.priceTagRules-ecs_ingress_protocol
          self        = var.priceTagRules-ecs_ingress_self
          sg_name     = var.price_printing_nlb_sg_name
        },
        {
          description = var.priceTagRules_ecs_ingress_description_prices
          from_port   = var.priceTagRules_ecs_ingress_from_port_prices
          to_port     = var.priceTagRules_ecs_ingress_to_port_prices
          protocol    = var.priceTagRules_ecs_ingress_protocol_prices
          self        = var.priceTagRules_ecs_ingress_self_prices
          sg_name     = var.prices-ecs_sg_name
        },
        {
          description = var.priceTagRules_ecs_ingress_description_segments
          from_port   = var.priceTagRules_ecs_ingress_from_port_segments
          to_port     = var.priceTagRules_ecs_ingress_to_port_segments
          protocol    = var.priceTagRules_ecs_ingress_protocol_segments
          self        = var.priceTagRules_ecs_ingress_self_segments
          sg_name     = var.priceTagSegments-ecs_sg_name
        },
        {
          description = var.priceTagRules_ecs_ingress_description_priceshistory
          from_port   = var.priceTagRules_ecs_ingress_from_port_priceshistory
          to_port     = var.priceTagRules_ecs_ingress_to_port_priceshistory
          protocol    = var.priceTagRules_ecs_ingress_protocol_priceshistory
          self        = var.priceTagRules_ecs_ingress_self_priceshistory
          sg_name     = var.priceHistory-ecs_sg_name
        }
      ]
      egress_rules = [
        {
          description = var.priceTagRules-ecs_egress_description
          from_port   = var.priceTagRules-ecs_egress_from_port
          to_port     = var.priceTagRules-ecs_egress_to_port
          protocol    = var.priceTagRules-ecs_egress_protocol
          cidr_blocks = var.cidr_blocks_ecs
        }
      ]
    },
    # Impresión de precios - Security Group - ECS priceHistory
    {
      name        = var.priceHistory-ecs_sg_name
      description = var.priceHistory-ecs_sg_description
      ingress_rules = [
        {
          description = var.priceHistory-ecs_ingress_description
          from_port   = var.priceHistory-ecs_ingress_from_port
          to_port     = var.priceHistory-ecs_ingress_to_port
          protocol    = var.priceHistory-ecs_ingress_protocol
          self        = var.priceHistory-ecs_ingress_self
          sg_name     = var.price_printing_nlb_sg_name
        },
        {
          description = var.priceHistory_ecs_ingress_description_prices
          from_port   = var.priceHistory_ecs_ingress_from_port_prices
          to_port     = var.priceHistory_ecs_ingress_to_port_prices
          protocol    = var.priceHistory_ecs_ingress_protocol_prices
          self        = var.priceHistory_ecs_ingress_self_prices
          sg_name     = var.prices-ecs_sg_name
        },
        {
          description = var.priceHistory_ecs_ingress_description_segments
          from_port   = var.priceHistory_ecs_ingress_from_port_segments
          to_port     = var.priceHistory_ecs_ingress_to_port_segments
          protocol    = var.priceHistory_ecs_ingress_protocol_segments
          self        = var.priceHistory_ecs_ingress_self_segments
          sg_name     = var.priceTagSegments-ecs_sg_name
        },
        {
          description = var.priceHistory_ecs_ingress_description_glue
          from_port   = var.priceHistory_ecs_ingress_from_port_glue
          to_port     = var.priceHistory_ecs_ingress_to_port_glue
          protocol    = var.priceHistory_ecs_ingress_protocol_glue
          self        = var.priceHistory_ecs_ingress_self_glue
          sg_name     = var.extraction_gluejobs_sg_name
        }
      ]
      egress_rules = [
        {
          description = var.priceHistory-ecs_egress_description
          from_port   = var.priceHistory-ecs_egress_from_port
          to_port     = var.priceHistory-ecs_egress_to_port
          protocol    = var.priceHistory-ecs_egress_protocol
          cidr_blocks = var.cidr_blocks_ecs
        }
      ]
    },
  ]
}


module "s3" {
  source        = "./Modules/S3"
  project       = var.project
  domain        = var.domain
  vpc_id        = module.vpc.id
  environment   = var.environment
  resource_tags = var.resource_tags

  s3_config = [
    # Bucket para código Lambda
    {
      name        = var.lambda_bucket_name
      description = var.lambda_bucket_description

      versioning = {
        enabled = var.lambda_versioning_enabled
      }

      server_side_encryption = {
        enabled     = var.lambda_sse_enabled
        kms_key_arn = module.kms.kms_keys["s3"].arn
      }

      lifecycle_rules = var.lambda_lifecycle_rules

      cors_rules = var.lambda_cors_rules
      statements = [
        {
          sid         = var.lambda_statement_sid
          actions     = var.lambda_statement_actions
          resources   = ["arn:aws:s3:::${var.project}-${var.domain}-${var.environment}-lambda-code/*"]
          effect      = var.lambda_statement_effect
          type        = var.lambda_statement_type
          identifiers = var.lambda_statement_identifiers
          condition   = var.lambda_statement_conditions
        }
      ]
    },

    # Bucket para datos externos
    {
      name        = var.external_bucket_name
      description = var.external_bucket_description

      versioning = {
        enabled = var.external_versioning_enabled
      }

      server_side_encryption = {
        enabled     = var.external_sse_enabled
        kms_key_arn = module.kms.kms_keys["s3"].arn
      }

      lifecycle_rules      = var.external_lifecycle_rules
      cors_rules           = var.external_cors_rules
      enable_notifications = var.enable_notifications

      notifications = [
        {
          name          = var.notification_names["normalization_store"]
          queue_arn     = "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.project}-${var.domain}-${var.environment}-${var.normalization_store_sqs_name}"
          events        = var.notification_events
          filter_prefix = var.notification_prefixes["stores"]
        },
        {
          name          = var.notification_names["comparison_store"]
          queue_arn     = "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.project}-${var.domain}-${var.environment}-${var.comparison_store_sqs_name}"
          events        = var.notification_events
          filter_prefix = var.notification_prefixes["normalized_stores"]
        },
        {
          name          = var.notification_names["normalization_user"]
          queue_arn     = "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.project}-${var.domain}-${var.environment}-${var.normalization_user_sqs_name}"
          events        = var.notification_events
          filter_prefix = var.notification_prefixes["users"]
        },
        {
          name          = var.notification_names["comparison_user"]
          queue_arn     = "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.project}-${var.domain}-${var.environment}-${var.comparison_user_sqs_name}"
          events        = var.notification_events
          filter_prefix = var.notification_prefixes["normalized_users"]
        }
      ]

      statements = [
        {
          sid         = var.external_statement_sid
          actions     = var.external_statement_actions
          resources   = ["arn:aws:s3:::${var.project}-${var.domain}-${var.environment}-external-data/*"]
          effect      = var.external_statement_effect
          type        = var.external_statement_type
          identifiers = local.extraction_role_arns
          condition   = var.external_statement_conditions
        }
      ]
    },

    # Bucket para integracion con Glue Jobs
    {
      name        = var.glue_bucket_name
      description = var.glue_bucket_description

      versioning = {
        enabled = var.glue_versioning_enabled
      }

      server_side_encryption = {
        enabled     = var.glue_sse_enabled
        kms_key_arn = module.kms.kms_keys["s3"].arn
      }

      lifecycle_rules = var.glue_lifecycle_rules

      cors_rules = var.glue_cors_rules
      statements = [
        {
          sid         = var.glue_statement_sid
          actions     = var.glue_statement_actions
          resources   = ["arn:aws:s3:::${var.project}-${var.domain}-${var.environment}-materials/*"]
          effect      = var.glue_statement_effect
          type        = var.glue_statement_type
          identifiers = var.glue_statement_identifiers
          condition   = var.glue_statement_conditions
        }
      ]
    },
    # Bucket general para integraciones con Glue
    {
      name        = var.glue_general_bucket_name
      description = var.glue_general_bucket_description
      versioning = {
        enabled = var.glue_general_versioning_enabled
      }
      server_side_encryption = {
        enabled     = var.glue_general_sse_enabled
        kms_key_arn = module.kms.kms_keys["s3"].arn
      }
      lifecycle_rules = var.glue_general_lifecycle_rules
      cors_rules      = var.glue_general_cors_rules
      statements = [
        {
          sid         = var.glue_general_statement_sid
          actions     = var.glue_general_statement_actions
          resources   = ["arn:aws:s3:::${var.project}-${var.domain}-${var.environment}-glue/*"]
          effect      = var.glue_general_statement_effect
          type        = var.glue_general_statement_type
          identifiers = var.glue_general_statement_identifiers
          condition   = var.glue_general_statement_conditions
        }
      ]
    },
    # Bucket general para logs de pipeline trivi
    {
      name        = var.logs_trivi_bucket_name
      description = var.logs_trivi_bucket_description
      versioning = {
        enabled = var.logs_trivi_versioning_enabled
      }
      server_side_encryption = {
        enabled     = var.logs_trivi_sse_enabled
        kms_key_arn = module.kms.kms_keys["s3"].arn
      }
      lifecycle_rules = var.logs_trivi_lifecycle_rules
      cors_rules      = var.logs_trivi_cors_rules
      statements = [
        {
          sid         = var.logs_trivi_statement_sid
          actions     = var.logs_trivi_statement_actions
          resources   = ["arn:aws:s3:::${var.project}-${var.domain}-${var.environment}-glue/*"]
          effect      = var.logs_trivi_statement_effect
          type        = var.logs_trivi_statement_type
          identifiers = var.logs_trivi_statement_identifiers
          condition   = var.logs_trivi_statement_conditions
        }
      ]
    },
    # Bucket general para .json de Step Functions
    {
      name        = var.stepfunction_bucket_name
      description = var.stepfunction_bucket_description
      versioning = {
        enabled = var.stepfunction_versioning_enabled
      }
      server_side_encryption = {
        enabled     = var.stepfunction_sse_enabled
        kms_key_arn = module.kms.kms_keys["s3"].arn
      }
      lifecycle_rules = var.stepfunction_lifecycle_rules
      cors_rules      = var.stepfunction_cors_rules
      statements = [
        {
          sid         = var.stepfunction_statement_sid
          actions     = var.stepfunction_statement_actions
          resources   = ["arn:aws:s3:::${var.project}-${var.domain}-${var.environment}-glue/*"]
          effect      = var.stepfunction_statement_effect
          type        = var.stepfunction_statement_type
          identifiers = var.stepfunction_statement_identifiers
          condition   = var.stepfunction_statement_conditions
        }
      ]
    }
  ]
}


module "lambda" {
  source         = "./Modules/Lambda"
  project        = var.project
  environment    = var.environment
  domain         = var.domain
  aws_region     = var.aws_region
  db_secret_name = var.db_secret_name
  resource_tags  = var.resource_tags

  secrets_db_kms_key_arn         = module.kms.kms_keys["secrets-db"].arn
  dynamo_kms_key_arn             = module.kms.kms_keys["dynamo"].arn
  dynamo_kms_key_arn_secrets_api = module.kms.kms_keys["secrets-api"].arn

  secretsmanager_arn_database_credentials = module.secrets_manager.secrets["database-credentials"].arn
  secretsmanager_arn_cognito_credentials  = module.secrets_manager.secrets["cognito-credentials"].arn


  api_gateway_execution_arn = module.api_gateway.api_execution_arn["${var.api_name}"]

  extraction_store_function_name    = var.extraction_store_function_name
  extraction_user_function_name     = var.extraction_user_function_name
  normalization_store_function_name = var.normalization_store_function_name
  normalization_user_function_name  = var.normalization_user_function_name
  comparison_store_function_name    = var.comparison_store_function_name
  comparison_user_function_name     = var.comparison_user_function_name
  token_function_name               = var.token_function_name
  refresh_token_function_name       = var.refresh_token_function_name

  api_user_function_name  = var.api_user_function_name
  api_store_function_name = var.api_store_function_name

  api_authorizer_function_name = var.api_authorizer_function_name
  # Variables para el procesamiento SQS
  batch_size                         = var.batch_size
  maximum_batching_window_in_seconds = var.maximum_batching_window_in_seconds
  sqs_trigger_enabled                = var.sqs_trigger_enabled

  sqs_trigger_mappings = {
    "normalization-store-sqs" = var.normalization_store_function_name
    "comparison-store-sqs"    = var.comparison_store_function_name
    "normalization-user-sqs"  = var.normalization_user_function_name
    "comparison-user-sqs"     = var.comparison_user_function_name
  }

  # Mapeo de colas SQS (actualizado para incluir nuevas lambdas)
  sqs_queue_arns = {
    "normalization-store-sqs" = module.sqs.sqs_queues["normalization-store-sqs"].arn
    "comparison-store-sqs"    = module.sqs.sqs_queues["comparison-store-sqs"].arn
    "normalization-user-sqs"  = module.sqs.sqs_queues["normalization-user-sqs"].arn
    "comparison-user-sqs"     = module.sqs.sqs_queues["comparison-user-sqs"].arn
  }

  lambda_layers = {
    boto3_arn         = var.boto3_arn
    cx_oracle_arn     = var.cx_oracle_arn
    instaclient_layer = var.instaclient_layer
    cryptography      = var.cryptography
    requests          = var.requests
    pyjwt             = var.pyjwt
    jwt               = var.jwt
  }

  lambda_config = [
    # Lambda Extraction
    {
      function_name = var.extraction_store_function_name
      description   = var.extraction_store_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.extraction_store_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      environment_variables = {
        ENV                    = var.environment
        LD_LIBRARY_PATH        = "/opt/python/instantclient_21_18"
        S3_BUCKET              = module.s3.s3_buckets["external-data"].id
        S3_BUCKET_NAME         = module.s3.s3_buckets["external-data"].id
        FOLDER_DATA_EXTRACTION = "stores/"
        KMS_KEY_ARN            = module.kms.kms_keys["s3"].arn
        ORACLE_SECRET_NAME     = module.secrets_manager.secrets["database-credentials"].name
        LOG_FILTER_LEVEL       = "ALL"
      }

      permissions = [
        {
          statement_id = var.dynamo_statement_id
          actions      = var.dynamo_actions
          resources    = [for table in module.dynamo.dynamodb_tables : table.arn]
          principal    = var.dynamo_principal
          source_arn   = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        }
      ]

      vpc_config = {
        subnet_ids = [for subnet in module.vpc.subnets : subnet.id]
        security_group_ids = [
          module.security_groups.security_groups["extraction-lambda"].id,
          module.security_groups.security_groups["extraction-gluejobs"].id
        ]
      }
      tags = var.extraction_store_tags
    },
    # Lambda Extraction User
    {
      function_name = var.extraction_user_function_name
      description   = var.extraction_user_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.extraction_user_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      environment_variables = {
        ENV                    = var.environment
        LD_LIBRARY_PATH        = "/opt/python/instantclient_21_18"
        S3_BUCKET              = module.s3.s3_buckets["external-data"].id
        S3_BUCKET_NAME         = module.s3.s3_buckets["external-data"].id
        FOLDER_DATA_EXTRACTION = "users/"
        KMS_KEY_ARN            = module.kms.kms_keys["s3"].arn
        ORACLE_SECRET_NAME     = module.secrets_manager.secrets["database-credentials"].name
        LOG_FILTER_LEVEL       = "ALL"
      }

      permissions = [
        {
          statement_id = var.dynamo_statement_id
          actions      = var.dynamo_actions
          resources    = [for table in module.dynamo.dynamodb_tables : table.arn]
          principal    = var.dynamo_principal
          source_arn   = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        }
      ]

      vpc_config = {
        subnet_ids = [for subnet in module.vpc.subnets : subnet.id]
        security_group_ids = [
          module.security_groups.security_groups["extraction-lambda"].id,
          module.security_groups.security_groups["extraction-gluejobs"].id
        ]
      }
      tags = var.extraction_user_tags
    },
    # Lambda Comparison
    {
      function_name = var.comparison_store_function_name
      description   = var.comparison_store_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.comparison_store_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      dynamodb_table_arns = [
        module.dynamo.dynamodb_tables["users"].arn,
        module.dynamo.dynamodb_tables["store"].arn,
        module.dynamo.dynamodb_tables["new-store"].arn
      ]

      environment_variables = {
        ENV               = var.environment
        PREVIOUS_FILE     = "previous_stores.csv"
        STORES_TABLE      = module.dynamo.dynamodb_tables["store"].id
        HISTORICAL_TABLE  = module.dynamo.dynamodb_tables["new-store"].id
        FOLDER_PREVIOUS   = "previous_stores"
        HISTORICAL_FOLDER = "historical_files"
        S3_BUCKET         = module.s3.s3_buckets["external-data"].id
        S3_BUCKET_NAME    = module.s3.s3_buckets["external-data"].id
        LOG_FILTER_LEVEL  = "ALL"
      }

      permissions = [
        {
          statement_id = var.sqs_statement_id
          actions      = var.sqs_actions
          resources    = [for queue in module.sqs.sqs_queues : queue.arn]
          principal    = var.sqs_principal
          source_arn   = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        },
        {
          statement_id = "AllowDynamoDBAccess"
          actions = [
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:Query"
          ]
          resources = [
            module.dynamo.dynamodb_tables["users"].arn,
            module.dynamo.dynamodb_tables["store"].arn,
            module.dynamo.dynamodb_tables["new-store"].arn
          ]
          principal  = "dynamodb.amazonaws.com"
          source_arn = null
        }
      ]
      tags = var.comparison_store_tags
    },
    # Lambda Comparison User
    {
      function_name = var.comparison_user_function_name
      description   = var.comparison_user_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.comparison_user_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      dynamodb_table_arns = [
        module.dynamo.dynamodb_tables["users"].arn,
        module.dynamo.dynamodb_tables["store"].arn,
        module.dynamo.dynamodb_tables["new-store"].arn
      ]

      environment_variables = {
        ENV               = var.environment
        PREVIOUS_FILE     = "previous_users.csv"
        USERS_TABLE       = module.dynamo.dynamodb_tables["users"].id
        HISTORICAL_TABLE  = module.dynamo.dynamodb_tables["new-store"].id
        FOLDER_PREVIOUS   = "previous_users"
        HISTORICAL_FOLDER = "historical_users"
        S3_BUCKET         = module.s3.s3_buckets["external-data"].id
        S3_BUCKET_NAME    = module.s3.s3_buckets["external-data"].id
        LOG_FILTER_LEVEL  = "ALL"
      }

      permissions = [
        {
          statement_id = var.sqs_statement_id
          actions      = var.sqs_actions
          resources    = [for queue in module.sqs.sqs_queues : queue.arn]
          principal    = var.sqs_principal
          source_arn   = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        },
        {
          statement_id = "AllowDynamoDBAccess"
          actions = [
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:Query"
          ]
          resources = [
            module.dynamo.dynamodb_tables["users"].arn,
            module.dynamo.dynamodb_tables["store"].arn,
            module.dynamo.dynamodb_tables["new-store"].arn
          ]
          principal  = "dynamodb.amazonaws.com"
          source_arn = null
        }
      ]
      tags = var.comparison_user_tags
    },
    # Lambda Normalization
    {
      function_name = var.normalization_store_function_name
      description   = var.normalization_store_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.normalization_store_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      environment_variables = {
        ENV                      = var.environment
        NORMALIZED_STORES_FOLDER = "normalized_stores"
        NORMALIZED_KEY           = "archivo_normalizado.csv"
        S3_BUCKET                = module.s3.s3_buckets["external-data"].id
        S3_BUCKET_NAME           = module.s3.s3_buckets["external-data"].id
        LOG_FILTER_LEVEL         = "ALL"
      }

      permissions = [
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        }
      ]
      tags = var.normalization_store_tags
    },
    # Lambda Normalization User
    {
      function_name = var.normalization_user_function_name
      description   = var.normalization_user_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.normalization_user_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      environment_variables = {
        ENV                     = var.environment
        NORMALIZED_USERS_FOLDER = "normalized_users"
        NORMALIZED_KEY          = "archivo_normalizado_user.csv"
        S3_BUCKET               = module.s3.s3_buckets["external-data"].id
        S3_BUCKET_NAME          = module.s3.s3_buckets["external-data"].id
        LOG_FILTER_LEVEL        = "ALL"
      }

      permissions = [
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        }
      ]

      tags = var.normalization_user_tags
    },
    # Nueva Lambda para API Users
    {
      function_name = var.api_user_function_name
      description   = var.api_user_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.api_user_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      environment_variables = {
        ENV                  = var.environment
        USERS_TABLE          = module.dynamo.dynamodb_tables["users"].id
        TOKENS_TABLE         = module.dynamo.dynamodb_tables["token"].id
        USERS_HISTORY_TABLE  = module.dynamo.dynamodb_tables["users"].id
        S3_BUCKET            = module.s3.s3_buckets["external-data"].id
        COGNITO_USER_POOL_ID = module.cognito.user_pools[var.user_pool_name].id
        LOG_FILTER_LEVEL     = "ALL"
      }

      permissions = [
        {
          statement_id = var.dynamo_statement_id
          actions      = var.dynamo_actions
          resources = [
            module.dynamo.dynamodb_tables["users"].arn,
            module.dynamo.dynamodb_tables["users"].arn
          ]
          principal  = var.dynamo_principal
          source_arn = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        },
        {
          statement_id = var.cognito_statement_id
          actions      = var.cognito_actions
          resources    = [module.cognito.user_pools[var.user_pool_name].arn]
          principal    = var.cognito_principal
          source_arn   = null
        },
        {
          statement_id = var.api_gateway_statement_id
          actions      = var.api_gateway_actions
          resources    = [null]
          principal    = var.api_gateway_principal
          source_arn   = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.api_name}/*/*"
        }
      ]

      tags = var.api_user_tags
    },

    # Nueva Lambda para API Stores
    {
      function_name = var.api_store_function_name
      description   = var.api_store_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.api_store_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      # dynamodb_table_arns = [
      #   module.dynamo.dynamodb_tables["users"].arn,
      #   module.dynamo.dynamodb_tables["store"].arn,
      #   module.dynamo.dynamodb_tables["new-store"].arn
      # ]

      environment_variables = {
        ENV                  = var.environment
        STORES_TABLE         = module.dynamo.dynamodb_tables["store"].id
        TOKENS_TABLE         = module.dynamo.dynamodb_tables["token"].id
        ENDPOINTS_TABLE      = module.dynamo.dynamodb_tables["endpoint"].id
        S3_BUCKET            = module.s3.s3_buckets["external-data"].id
        COGNITO_USER_POOL_ID = module.cognito.user_pools[var.user_pool_name].id
        LOG_FILTER_LEVEL     = "ALL"
      }

      permissions = [
        {
          statement_id = var.dynamo_statement_id
          actions      = var.dynamo_actions
          resources = [
            module.dynamo.dynamodb_tables["store"].arn,
            module.dynamo.dynamodb_tables["store"].arn
          ]
          principal  = var.dynamo_principal
          source_arn = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        },
        {
          statement_id = var.cognito_statement_id
          actions      = var.cognito_actions
          resources    = [module.cognito.user_pools[var.user_pool_name].arn]
          principal    = var.cognito_principal
          source_arn   = null
        },
        {
          statement_id = var.api_gateway_statement_id
          actions      = var.api_gateway_actions
          resources    = [null] # Se completará con el ARN de la función Lambda
          principal    = var.api_gateway_principal
          source_arn   = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.api_name}/*/*"
        }
      ]

      tags = var.api_store_tags
    },
    # Lambda Authorizer
    {
      function_name = var.api_authorizer_function_name
      description   = var.api_authorizer_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.api_authorizer_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      # secretsmanager_arns = [
      #   module.secrets_manager.secrets["cognito-credentials"].arn
      # ] 

      environment_variables = {
        COGNITO_SECRETS_NAME  = module.secrets_manager.secrets["cognito-credentials"].arn
        ENDPOINT_TABLE_NAME   = module.dynamo.dynamodb_tables["endpoint"].id
        PERMISSION_TABLE_NAME = module.dynamo.dynamodb_tables["permission"].id
        LOG_FILTER_LEVEL      = "ALL"
      }

      permissions = [
        {
          statement_id = "AllowDynamoDBAccess"
          actions = [
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:Query"
          ]
          resources = [
            module.dynamo.dynamodb_tables["users"].arn,
            module.dynamo.dynamodb_tables["token"].arn
          ]
          principal  = "dynamodb.amazonaws.com"
          source_arn = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        },
        {
          statement_id = "AllowCognitoAccess"
          actions = [
            "cognito-idp:AdminGetUser",
            "cognito-idp:ListUsers",
            "cognito-idp:VerifyAccessToken"
          ]
          resources  = [module.cognito.user_pools[var.user_pool_name].arn]
          principal  = "cognito-idp.amazonaws.com"
          source_arn = null
        }
      ]
      tags = var.api_authorizer_tags
    },
    # Lambda Token
    {
      function_name = var.token_function_name
      description   = var.token_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.token_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      environment_variables = {
        COGNITO_SECRETS_NAME = module.secrets_manager.secrets["cognito-credentials"].name
        ENV                  = var.environment
        LOG_FILTER_LEVEL     = "ALL"
      }

      permissions = [
        {
          statement_id = var.dynamo_statement_id
          actions      = var.dynamo_actions
          resources = [
            module.dynamo.dynamodb_tables["users"].arn,
            module.dynamo.dynamodb_tables["token"].arn
          ]
          principal  = var.dynamo_principal
          source_arn = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        },
        {
          statement_id = var.cognito_statement_id
          actions      = var.cognito_actions
          resources    = [module.cognito.user_pools[var.user_pool_name].arn]
          principal    = var.cognito_principal
          source_arn   = null
        },
        {
          statement_id = var.secretsmanager_statement_id
          actions      = var.secretsmanager_actions
          resources    = [module.secrets_manager.secrets["cognito-credentials"].arn]
          principal    = var.secretsmanager_principal
          source_arn   = null
        }
      ]

      tags = var.token_tags
    },

    # Lambda login
    {
      function_name = var.refresh_token_function_name
      description   = var.refresh_token_description
      runtime       = var.lambda_runtime
      handler       = var.lambda_handler
      memory_size   = var.memory_size
      timeout       = var.timeout
      s3_key        = var.refresh_token_s3_key
      s3_bucket_arn = module.s3.s3_buckets["external-data"].arn
      kms_key_arn   = module.kms.kms_keys["s3"].arn

      environment_variables = {
        ENV                  = var.environment
        COGNITO_SECRETS_NAME = module.secrets_manager.secrets["cognito-credentials"].name
        LOG_FILTER_LEVEL     = "ALL"
      }

      permissions = [
        {
          statement_id = var.dynamo_statement_id
          actions      = var.dynamo_actions
          resources = [
            module.dynamo.dynamodb_tables["users"].arn,
            module.dynamo.dynamodb_tables["token"].arn
          ]
          principal  = var.dynamo_principal
          source_arn = null
        },
        {
          statement_id = var.s3_statement_id
          actions      = var.s3_actions
          resources    = [for bucket in module.s3.s3_buckets : bucket.arn]
          principal    = var.s3_principal
          source_arn   = null
        },
        {
          statement_id = var.kms_statement_id_lambda
          actions      = var.kms_actions_lambda
          resources    = [for key in module.kms.kms_keys : key.arn]
          principal    = var.kms_principal_lambda
          source_arn   = null
        },
        {
          statement_id = var.cognito_statement_id
          actions      = var.cognito_actions
          resources    = [module.cognito.user_pools[var.user_pool_name].arn]
          principal    = var.cognito_principal
          source_arn   = null
        }
      ]

      tags = var.refresh_token_tags
    }
  ]
}


module "eventbridge" {
  source        = "./Modules/EventBridge"
  project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags

  eventbridge_config = [
    {
      name                = var.event_rule_name
      description         = var.event_rule_description
      schedule_expression = var.schedule_cron
      targets = [
        {
          lambda_function_arn     = module.lambda.lambda_functions["extraction-store"].arn
          lambda_function_name    = module.lambda.lambda_functions["extraction-store"].function_name
          permission_statement_id = var.event_target_id
          lambda_action           = var.event_rule_lambda_action
          lambda_principal        = var.event_rule_lambda_principal
          target_id               = "extraction-store-target"
        },
        {
          lambda_function_arn     = module.lambda.lambda_functions["extraction-user"].arn
          lambda_function_name    = module.lambda.lambda_functions["extraction-user"].function_name
          permission_statement_id = "${var.event_target_id}-user"
          lambda_action           = var.event_rule_lambda_action
          lambda_principal        = var.event_rule_lambda_principal
          target_id               = "extraction-user-target"
        }
      ]
    },
    # Nueva regla para Step Functions
    {
      name                = var.stepfunction_rule_name
      description         = var.stepfunction_rule_description
      schedule_expression = var.stepfunction_schedule_cron
      stepfunction_targets = [
        {
          stepfunction_arn = module.step_function_state_machines.step_functions["prices"].arn
          target_id        = "stepfunction-target"
          input = jsonencode({
            "execution_number" = "1"
            "reprocess"        = "No"
          })
        }
      ]
    }
  ]
}

module "sqs" {
  source        = "./Modules/SQS"
  environment   = var.environment
  project       = var.project
  domain        = var.domain
  aws_region    = var.aws_region
  resource_tags = var.resource_tags

  sqs_config = [
    {
      name                       = var.normalization_store_sqs_name
      delay_seconds              = var.delay_seconds
      max_message_size           = var.max_message_size
      message_retention_seconds  = var.message_retention_seconds
      receive_wait_time_seconds  = var.receive_wait_time_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds
      dead_letter_queue          = var.main_queue_dlq_enabled
      fifo_queue                 = var.fifo_queue
      kms_master_key_id          = var.kms_master_key_id
      statements = [
        {
          sid         = var.sqs_lambda_statement_sid
          actions     = var.sqs_lambda_actions
          resources   = ["*"]
          effect      = var.sqs_lambda_effect
          type        = var.sqs_lambda_type
          identifiers = var.sqs_lambda_identifiers
          condition = [
            {
              test     = var.sqs_lambda_condition_test
              variable = var.sqs_lambda_condition_variable
              values   = var.sqs_lambda_condition_values
            }
          ]
        },
        {
          sid         = var.sqs_s3_statement_sid
          actions     = var.sqs_s3_actions
          resources   = ["*"]
          effect      = var.sqs_s3_effect
          type        = var.sqs_s3_type
          identifiers = var.sqs_s3_identifiers
          condition = [
            {
              test     = var.sqs_s3_condition_test
              variable = var.sqs_s3_condition_variable
              values   = [module.s3.s3_buckets["external-data"].arn]
            }
          ]
        }
      ]
    },
    {
      name                       = var.comparison_store_sqs_name
      delay_seconds              = var.delay_seconds
      max_message_size           = var.max_message_size
      message_retention_seconds  = var.dlq_message_retention_seconds
      receive_wait_time_seconds  = var.receive_wait_time_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds
      dead_letter_queue          = var.dlq_queue_dlq_enabled
      fifo_queue                 = var.fifo_queue
      kms_master_key_id          = var.kms_master_key_id
      statements = [
        {
          sid         = var.sqs_lambda_statement_sid
          actions     = var.sqs_lambda_actions
          resources   = ["*"]
          effect      = var.sqs_lambda_effect
          type        = var.sqs_lambda_type
          identifiers = var.sqs_lambda_identifiers
          condition = [
            {
              test     = var.sqs_lambda_condition_test
              variable = var.sqs_lambda_condition_variable
              values   = var.sqs_lambda_condition_values
            }
          ]
        },
        {
          sid         = var.sqs_s3_statement_sid
          actions     = var.sqs_s3_actions
          resources   = ["*"]
          effect      = var.sqs_s3_effect
          type        = var.sqs_s3_type
          identifiers = var.sqs_s3_identifiers
          condition = [
            {
              test     = var.sqs_s3_condition_test
              variable = var.sqs_s3_condition_variable
              values   = [module.s3.s3_buckets["external-data"].arn]
            }
          ]
        }
      ]
    },
    {
      name                       = var.normalization_user_sqs_name
      delay_seconds              = var.delay_seconds
      max_message_size           = var.max_message_size
      message_retention_seconds  = var.message_retention_seconds
      receive_wait_time_seconds  = var.receive_wait_time_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds
      dead_letter_queue          = var.main_queue_dlq_enabled
      fifo_queue                 = var.fifo_queue
      kms_master_key_id          = var.kms_master_key_id
      statements = [
        {
          sid         = var.sqs_lambda_statement_sid
          actions     = var.sqs_lambda_actions
          resources   = ["*"]
          effect      = var.sqs_lambda_effect
          type        = var.sqs_lambda_type
          identifiers = var.sqs_lambda_identifiers
          condition = [
            {
              test     = var.sqs_lambda_condition_test
              variable = var.sqs_lambda_condition_variable
              values   = var.sqs_lambda_condition_values
            }
          ]
        },
        {
          sid         = var.sqs_s3_statement_sid
          actions     = var.sqs_s3_actions
          resources   = ["*"]
          effect      = var.sqs_s3_effect
          type        = var.sqs_s3_type
          identifiers = var.sqs_s3_identifiers
          condition = [
            {
              test     = var.sqs_s3_condition_test
              variable = var.sqs_s3_condition_variable
              values   = [module.s3.s3_buckets["external-data"].arn]
            }
          ]
        }
      ]
    },
    {
      name                       = var.comparison_user_sqs_name
      delay_seconds              = var.delay_seconds
      max_message_size           = var.max_message_size
      message_retention_seconds  = var.dlq_message_retention_seconds
      receive_wait_time_seconds  = var.receive_wait_time_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds
      dead_letter_queue          = var.dlq_queue_dlq_enabled
      fifo_queue                 = var.fifo_queue
      kms_master_key_id          = var.kms_master_key_id
      statements = [
        {
          sid         = var.sqs_lambda_statement_sid
          actions     = var.sqs_lambda_actions
          resources   = ["*"]
          effect      = var.sqs_lambda_effect
          type        = var.sqs_lambda_type
          identifiers = var.sqs_lambda_identifiers
          condition = [
            {
              test     = var.sqs_lambda_condition_test
              variable = var.sqs_lambda_condition_variable
              values   = var.sqs_lambda_condition_values
            }
          ]
        },
        {
          sid         = var.sqs_s3_statement_sid
          actions     = var.sqs_s3_actions
          resources   = ["*"]
          effect      = var.sqs_s3_effect
          type        = var.sqs_s3_type
          identifiers = var.sqs_s3_identifiers
          condition = [
            {
              test     = var.sqs_s3_condition_test
              variable = var.sqs_s3_condition_variable
              values   = [module.s3.s3_buckets["external-data"].arn]
            }
          ]
        }
      ]
    }
  ]
}

module "dynamo" {
  source      = "./Modules/Dynamo DB"
  project     = var.project
  domain      = var.domain
  environment = var.environment
  cost_center = var.cost_center
  owner       = var.owner


  dynamo_config = [
    # Tabla Users
    {
      name           = var.users_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.users_hash_key
      #range_key                 = var.users_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.users_attributes
      global_secondary_indexes    = var.users_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.users_replicas
    },
    # Tabla store
    {
      name           = var.products_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.products_hash_key
      #range_key                 = var.products_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.products_attributes
      global_secondary_indexes    = var.products_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.products_replicas
    },

    # Tabla Orders
    {
      name           = var.orders_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.orders_hash_key
      #range_key                 = var.orders_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.orders_attributes
      global_secondary_indexes    = []
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.orders_replicas
    },
    {
      name           = var.application_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.application_hash_key
      #range_key                 = var.application_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.application_attributes
      global_secondary_indexes    = var.application_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.application_replicas
    },

    # Tabla Endpoint
    {
      name           = var.endpoint_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.endpoint_hash_key
      #range_key                 = var.endpoint_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.endpoint_attributes
      global_secondary_indexes    = var.endpoint_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.endpoint_replicas
    },

    # Tabla permission
    {
      name           = var.app_endpoint_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.app_endpoint_hash_key
      #range_key                 = var.app_endpoint_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.app_endpoint_attributes
      global_secondary_indexes    = var.app_endpoint_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.app_endpoint_replicas
    },

    # Tabla Text
    {
      name           = var.text_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.text_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.text_attributes
      global_secondary_indexes    = var.text_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.text_replicas
    },
    # Tabla Materials
    {
      name           = var.materials_table_name
      billing_mode = var.materials_billing_mode
      # read_capacity  = var.materials_read_capacity
      # write_capacity = var.materials_write_capacity
      hash_key       = var.materials_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.materials_deletion_protection_enabled
      point_in_time_recovery      = var.materials_point_in_time_recovery
      attributes                  = var.materials_attributes
      global_secondary_indexes    = var.materials_gsi
      server_side_encryption = [
        {
          enabled     = var.materials_server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.materials_replicas
    },
    # Tabla price_history
    {
      name           = var.price_history_table_name
      billing_mode = var.price_history_billing_mode
      # read_capacity  = var.price_history_read_capacity
      # write_capacity = var.price_history_write_capacity
      hash_key       = var.price_history_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.price_history_deletion_protection_enabled
      point_in_time_recovery      = var.price_history_point_in_time_recovery
      attributes                  = var.price_history_attributes
      global_secondary_indexes    = var.price_history_gsi
      server_side_encryption = [
        {
          enabled     = var.price_history_server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.price_history_replicas
    },
    # Tabla notes
    {
      name           = var.notes_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.notes_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.notes_attributes
      global_secondary_indexes    = var.notes_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.notes_replicas
    },
    # Tabla prices
    {
      name           = var.prices_table_name
      billing_mode = var.prices_billing_mode
      # read_capacity  = var.prices_read_capacity
      # write_capacity = var.prices_write_capacity
      hash_key       = var.prices_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.prices_deletion_protection_enabled
      point_in_time_recovery      = var.prices_point_in_time_recovery
      attributes                  = var.prices_attributes
      global_secondary_indexes    = var.prices_gsi
      server_side_encryption = [
        {
          enabled     = var.prices_server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.prices_replicas
    },
    # Tabla PriceTagSegment
    {
      name           = var.PriceTagSegment_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.PriceTagSegment_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.PriceTagSegment_attributes
      global_secondary_indexes    = var.PriceTagSegment_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.PriceTagSegment_replicas
    },
    # Tabla PriceTagRule
    {
      name           = var.PriceTagRule_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.PriceTagRule_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.PriceTagRule_attributes
      global_secondary_indexes    = var.PriceTagRule_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.PriceTagRule_replicas
    },
     # Tabla regionals
    {
      name           = var.regionals_table_name
      billing_mode   = var.billing_mode
      read_capacity  = var.read_capacity
      write_capacity = var.write_capacity
      hash_key       = var.regionals_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.deletion_protection_enabled
      point_in_time_recovery      = var.point_in_time_recovery
      attributes                  = var.regionals_attributes
      global_secondary_indexes    = var.regionals_gsi
      server_side_encryption = [
        {
          enabled     = var.server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.regionals_replicas
    },

    # Tabla matCenters
    {
      name         = var.matCenters_table_name
      billing_mode = var.matCenters_billing_mode
      # read_capacity  = var.matCenters_read_capacity
      # write_capacity = var.matCenters_write_capacity
      hash_key = var.matCenters_hash_key
      #range_key                 = var.text_range_key
      deletion_protection_enabled = var.matCenters_deletion_protection_enabled
      point_in_time_recovery      = var.matCenters_point_in_time_recovery
      attributes                  = var.matCenters_attributes
      global_secondary_indexes    = var.matCenters_gsi
      server_side_encryption = [
        {
          enabled     = var.matCenters_server_side_encryption_enabled
          kms_key_arn = module.kms.kms_keys["dynamo"].arn
        }
      ]
      replicas = var.matCenters_replicas
    },
  ]
}

# Module call example
module "kms" {
  source        = "./Modules/KMS"
  project       = var.project
  environment   = var.environment
  domain        = var.domain
  resource_tags = var.resource_tags

  kms_config = [
    {
      alias                   = var.alias_dynamo
      description             = var.dynamo_description
      deletion_window_in_days = var.deletion_window_in_days
      enable_key_rotation     = var.enable_key_rotation
      multi_region            = var.multi_region
      statements = [
        {
          sid                   = var.dynamo_sid
          effect                = var.dynamo_effect
          actions               = var.dynamo_kms_actions
          principal_type        = var.dynamo_principal_type
          principal_identifiers = var.dynamo_principal_identifiers
          conditions            = var.dynamo_conditions
        }
      ]
    },
    {
      alias                   = var.alias_s3
      description             = var.s3_description
      deletion_window_in_days = var.deletion_window_in_days
      enable_key_rotation     = var.enable_key_rotation
      multi_region            = var.multi_region
      statements = [
        {
          sid                   = var.s3_sid
          effect                = var.s3_effect
          actions               = var.s3_kms_actions
          principal_type        = var.s3_principal_type
          principal_identifiers = var.s3_principal_identifiers
          conditions            = var.s3_conditions
        }
      ]
    },
    {
      alias                   = var.alias_secrets_api
      description             = var.secrets_api_description
      deletion_window_in_days = var.deletion_window_in_days
      enable_key_rotation     = var.enable_key_rotation
      multi_region            = var.multi_region
      statements = [
        {
          sid                   = var.secrets_api_sid
          effect                = var.secrets_api_effect
          actions               = var.secrets_api_kms_actions
          principal_type        = var.secrets_api_principal_type
          principal_identifiers = var.secrets_api_principal_identifiers
          conditions            = var.secrets_api_conditions
        }
      ]
    },
    {
      alias                   = var.alias_secrets_db
      description             = var.secrets_db_description
      deletion_window_in_days = var.deletion_window_in_days
      enable_key_rotation     = var.enable_key_rotation
      multi_region            = var.multi_region
      statements = [
        {
          sid                   = var.secrets_db_sid
          effect                = var.secrets_db_effect
          actions               = var.secrets_db_kms_actions
          principal_type        = var.secrets_db_principal_type
          principal_identifiers = var.secrets_db_principal_identifiers
          conditions            = var.secrets_db_conditions
        }
      ]
    },
    # Impresión de precios - kMS - Ecr
    {
      alias                   = var.alias_ecr
      description             = var.ecr_description
      deletion_window_in_days = var.deletion_window_in_days
      enable_key_rotation     = var.enable_key_rotation
      multi_region            = var.multi_region
      statements = [
        {
          sid                   = var.ecr_sid
          effect                = var.ecr_effect
          actions               = var.ecr_kms_actions
          principal_type        = var.ecr_principal_type
          principal_identifiers = var.ecr_principal_identifiers
          conditions            = var.ecr_conditions
        }
      ]
    }
  ]
}

# # ######################################################################
# # # API Gateway - Amazon 
# # ######################################################################

module "api_gateway" {
  source        = "./Modules/API Gateway"
  project       = var.project
  environment   = var.environment
  domain        = var.domain
  resource_tags = var.resource_tags

  api_method_settings = var.api_gateway_method_settings


  # Parámetros para el autorizador Lambda
  # Asegúrate de que estas variables apuntan a los nombres correctos de las funciones
  token_function_name             = module.lambda.lambda_functions[var.token_function_name].function_name
  refresh_token_function_name     = module.lambda.lambda_functions[var.refresh_token_function_name].function_name
  lambda_authorizer_invoke_arn    = module.lambda.lambda_functions[var.api_authorizer_function_name].invoke_arn
  lambda_authorizer_arn           = module.lambda.lambda_functions[var.api_authorizer_function_name].arn
  lambda_authorizer_function_name = module.lambda.lambda_functions[var.api_authorizer_function_name].function_name

  # Pasar los nombres de funciones Lambda
  lambda_function_names = {
    "${var.api_name}" = module.lambda.lambda_functions[var.api_user_function_name].function_name
  }

  ## Configuración del VPC Link
  vpc_link_config = {
    enabled     = true
    name        = "${var.project}-${var.domain}-${var.environment}-vpc-link"
    target_arns = [module.network_load_balancers.lb_arns["prices-nlb"]]
  }
  api_gateway_config = [
    {
      name           = var.api_name
      description    = var.api_description
      endpoint_types = var.endpoint_types
      resources = [
        # Recurso V1
        {
          path_part = var.v1_path_part
          path      = var.v1_path
          parent_id = "root"
          methods   = []
        },
        # Recurso Authentication
        {
          path_part = "authentication"
          path      = "v1/authentication"
          parent_id = "v1"
          methods   = []
        },
        # Recurso Login
        {
          path_part = "login"
          path      = "v1/authentication/login"
          parent_id = "v1/authentication"
          methods = [
            {
              http_method          = "POST"
              authorization        = "NONE"
              authorization_scopes = []
              request_parameters   = {}
              integration = {
                integration_http_method = "POST"
                type                    = "AWS_PROXY"
                uri                     = module.lambda.lambda_functions[var.token_function_name].invoke_arn
                request_templates       = {}
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Refresh Token
        {
          path_part = "refresh-token"
          path      = "v1/authentication/refresh-token"
          parent_id = "v1/authentication"
          methods = [
            {
              http_method          = "POST"
              authorization        = "NONE"
              authorization_scopes = []
              request_parameters   = {}
              integration = {
                integration_http_method = "POST"
                type                    = "AWS_PROXY"
                uri                     = module.lambda.lambda_functions[var.refresh_token_function_name].invoke_arn
                request_templates       = {}
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Organization
        {
          path_part = "organization"
          path      = "v1/organization"
          parent_id = "v1"
          methods   = []
        },
        # Recurso Users
        {
          path_part = "users"
          path      = "v1/organization/users"
          parent_id = "v1/organization"
          methods = [
            {
              http_method          = "GET"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = var.users_request_parameters
              integration = {
                integration_http_method = "POST"
                type                    = "AWS_PROXY"
                uri                     = module.lambda.lambda_functions[var.api_user_function_name].invoke_arn
                request_templates       = {}
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Stores
        {
          path_part = "stores"
          path      = "v1/organization/stores"
          parent_id = "v1/organization"
          methods = [
            {
              http_method          = "GET"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "POST"
                type                    = "AWS_PROXY"
                uri                     = module.lambda.lambda_functions[var.api_store_function_name].invoke_arn
                request_templates       = {}
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Materials (conecta con NLB via VPC Link)
        {
          path_part = "materials"
          path      = "v1/materials"
          parent_id = "v1"
          methods = [
            {
              http_method          = "GET"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "GET"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8081/v1/materials"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            },
            {
              http_method          = "POST"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "POST"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8081/v1/materials"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Prices ( conecta con NLB via VPC Link)
        {
          path_part = "price"
          path      = "v1/price"
          parent_id = "v1"
          methods   = []
        },
        # Recurso Prcies Notes (conecta con NLB via VPC Link)
        # Recurso Notes
        {
          path_part = "notes"
          path      = "v1/price/notes"
          parent_id = "v1/price"
          methods = [
            {
              http_method          = "GET"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "GET"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8080/v1/price/notes"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            },
            {
              http_method          = "POST"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "POST"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8080/v1/price/notes"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Notes con ID
        {
          path_part = "{id}"
          path      = "v1/price/notes/{id}"
          parent_id = "v1/price/notes"
          methods = [
            {
              http_method          = "PATCH"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters = {
                "method.request.path.id" = true
              }
              integration = {
                integration_http_method = "PATCH"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8080/v1/price/notes/{id}"
                request_templates       = {}
                request_parameters = {
                  "integration.request.path.id" = "method.request.path.id"
                }
                connection_type      = "VPC_LINK"
                connection_id        = module.api_gateway.vpc_link_id
                timeout_milliseconds = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Notes con associateMaterials
        {
          path_part = "associateMaterials"
          path      = "v1/price/notes/{id}/associateMaterials"
          parent_id = "v1/price/notes/{id}"
          methods = [
            {
              http_method          = "PATCH"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters = {
                "method.request.path.id" = true
              }
              integration = {
                integration_http_method = "PATCH"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8080/v1/price/notes/{id}/associateMaterials"
                request_templates       = {}
                request_parameters = {
                  "integration.request.path.id" = "method.request.path.id"
                }
                connection_type      = "VPC_LINK"
                connection_id        = module.api_gateway.vpc_link_id
                timeout_milliseconds = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Notes con disassociateMaterial
        {
          path_part = "disassociateMaterial"
          path      = "v1/price/notes/{id}/disassociateMaterial"
          parent_id = "v1/price/notes/{id}"
          methods = [
            {
              http_method          = "PATCH"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters = {
                "method.request.path.id" = true
              }
              integration = {
                integration_http_method = "PATCH"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8080/v1/price/notes/{id}/disassociateMaterial"
                request_templates       = {}
                request_parameters = {
                  "integration.request.path.id" = "method.request.path.id"
                }
                connection_type      = "VPC_LINK"
                connection_id        = module.api_gateway.vpc_link_id
                timeout_milliseconds = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso Prices
        # Recurso PriceTagSegments
        {
          path_part = "priceTagSegments"
          path      = "v1/price/priceTagSegments"
          parent_id = "v1/price"
          methods = [
            {
              http_method          = "GET"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "GET"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8083/v1/price/priceTagSegments"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            },
            {
              http_method          = "POST"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "POST"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8083/v1/price/priceTagSegments"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso PriceTagSegments con ID
        {
          path_part = "{id}"
          path      = "v1/price/priceTagSegments/{id}"
          parent_id = "v1/price/priceTagSegments"
          methods = [
            {
              http_method          = "PATCH"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters = {
                "method.request.path.id" = true
              }
              integration = {
                integration_http_method = "PATCH"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8083/v1/price/priceTagSegments/{id}"
                request_templates       = {}
                request_parameters = {
                  "integration.request.path.id" = "method.request.path.id"
                }
                connection_type      = "VPC_LINK"
                connection_id        = module.api_gateway.vpc_link_id
                timeout_milliseconds = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
         # Recurso historical
        {
          path_part = "historical"
          path      = "v1/price/historical"
          parent_id = "v1/price"
          methods = [
            {
              http_method          = "GET"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "GET"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8085/v1/price/historical"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso updateHistoricalETL
        {
          path_part = "updateHistoricalETL"
          path      = "v1/price/updateHistoricalETL"
          parent_id = "v1/price"
          methods = [
            {
              http_method          = "PATCH"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters = {
                "method.request.path.id" = true
              }
              integration = {
                integration_http_method = "PATCH"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8085/v1/price/updateHistoricalETL"
                request_templates       = {}
                request_parameters = {}
                connection_type      = "VPC_LINK"
                connection_id        = module.api_gateway.vpc_link_id
                timeout_milliseconds = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },


        # Recurso PriceTagRules
        {
          path_part = "priceTagRules"
          path      = "v1/price/priceTagRules"
          parent_id = "v1/price"
          methods = [
            {
              http_method          = "GET"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "GET"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8082/v1/price/priceTagRules"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            },
            {
              http_method          = "POST"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "POST"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8082/v1/price/priceTagRules"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso priceTagRules con ID
        {
          path_part = "{id}"
          path      = "v1/price/priceTagRules/{id}"
          parent_id = "v1/price/priceTagRules"
          methods = [
            {
              http_method          = "PATCH"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters = {
                "method.request.path.id" = true
              }
              integration = {
                integration_http_method = "PATCH"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8082/v1/price/priceTagRules/{id}"
                request_templates       = {}
                request_parameters = {
                  "integration.request.path.id" = "method.request.path.id"
                }
                connection_type      = "VPC_LINK"
                connection_id        = module.api_gateway.vpc_link_id
                timeout_milliseconds = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            },
            {
              http_method          = "DELETE"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters = {
                "method.request.path.id" = true
              }
              integration = {
                integration_http_method = "DELETE"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8082/v1/price/priceTagRules/{id}"
                request_templates       = {}
                request_parameters = {
                  "integration.request.path.id" = "method.request.path.id"
                }
                connection_type      = "VPC_LINK"
                connection_id        = module.api_gateway.vpc_link_id
                timeout_milliseconds = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
        # Recurso priceTagRules con segment
        {
          path_part = "segment"
          path      = "v1/price/priceTagRules/segment"
          parent_id = "v1/price/priceTagRules"
          methods   = []
        },
        # Recurso priceTagRules con validityDate
        {
          path_part = "validityDate"
          path      = "v1/price/priceTagRules/segment/validityDate"
          parent_id = "v1/price/priceTagRules/segment"
          methods = [
            {
              http_method          = "PATCH"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "PATCH"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8082/v1/price/priceTagRules/segment/validityDate"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },

        # Recurso Prices
        {
          path_part = "prices"
          path      = "v1/prices"
          parent_id = "v1"
          methods = [
            {
              http_method          = "GET"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "GET"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8084/v1/prices"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            },
            {
              http_method          = "POST"
              authorization        = "COGNITO_USER_POOLS"
              authorization_scopes = ["profile", "email", "openid"]
              request_parameters   = {}
              integration = {
                integration_http_method = "POST"
                type                    = "HTTP_PROXY"
                uri                     = "http://${module.network_load_balancers.lb_dns_names["prices-nlb"]}:8084/v1/prices"
                request_templates       = {}
                connection_type         = "VPC_LINK"
                connection_id           = module.api_gateway.vpc_link_id
                timeout_milliseconds    = 29000
              }
              responses = [
                {
                  status_code                    = "200"
                  response_models                = { "application/json" = "Empty" }
                  response_parameters            = {}
                  integration_response_templates = {}
                }
              ]
            }
          ]
        },
      ]
    }
  ]
}

# # # ######################################################################
# # # # Cognito - Amazon 
# # # ######################################################################

module "cognito" {
  source        = "./Modules/Cognito"
  project       = var.project
  environment   = var.environment
  domain        = var.domain
  resource_tags = var.resource_tags

  # Removed lambda_function_arn parameter

  cognito_config = [
    {
      name                     = var.user_pool_name
      username_attributes      = var.username_attributes
      auto_verified_attributes = var.auto_verified_attributes

      password_policy = {
        minimum_length                   = var.password_minimum_length
        require_lowercase                = var.password_require_lowercase
        require_numbers                  = var.password_require_numbers
        require_symbols                  = var.password_require_symbols
        require_uppercase                = var.password_require_uppercase
        temporary_password_validity_days = var.password_temporary_validity_days
      }

      mfa_configuration = var.mfa_configuration

      sms_configuration = {
        external_id    = var.sms_external_id
        sns_caller_arn = var.sms_caller_arn
      }

      email_configuration = {
        email_sending_account = var.email_sending_account
        from_email_address    = var.email_from_address
      }

      # Removed lambda_triggers

      schema_attributes = var.schema_attributes

      domain          = "${var.cognito_domain}-${var.project}-${var.environment}"
      certificate_arn = var.certificate_arn

      clients = [
        {
          name                                 = "api-client"
          generate_secret                      = true
          explicit_auth_flows                  = ["ADMIN_NO_SRP_AUTH", "USER_PASSWORD_AUTH"]
          allowed_oauth_flows                  = ["implicit"]
          allowed_oauth_flows_user_pool_client = true
          allowed_oauth_scopes                 = ["email", "openid", "profile"]
          callback_urls                        = ["https://example.com/callback"]
          logout_urls                          = ["https://example.com/logout"]
          supported_identity_providers         = ["COGNITO"]
          prevent_user_existence_errors        = "ENABLED"
          refresh_token_validity               = 7
          access_token_validity                = 60
          id_token_validity                    = 60
          token_validity_units = {
            refresh_token = "days"
            access_token  = "minutes"
            id_token      = "minutes"
          }
        }
      ]
    }
  ]
}

# # ######################################################################
# # #  Secrets Manager - Amazon 
# # ######################################################################

module "secrets_manager" {
  source        = "./Modules/Secrets Manager"
  project       = var.project
  environment   = var.environment
  domain        = var.domain
  resource_tags = var.resource_tags

  secrets_config = [
    {
      name                           = var.api_secret_name
      description                    = var.api_secret_description
      kms_key_id                     = module.kms.kms_keys[var.alias_secrets_api].arn
      recovery_window_in_days        = var.recovery_window_in_days
      force_overwrite_replica_secret = var.force_overwrite_replica_secret
      secret_string = jsonencode({
        username = var.api_secret_username
        password = var.api_secret_password
      })
      version_stages = var.api_version_stages
      policy         = var.api_secret_policy
      replicas       = var.api_replicas
    },
    {
      name                           = var.db_secret_name
      description                    = var.db_secret_description
      kms_key_id                     = module.kms.kms_keys[var.alias_secrets_db].arn
      recovery_window_in_days        = var.recovery_window_in_days
      force_overwrite_replica_secret = var.force_overwrite_replica_secret
      secret_string = jsonencode({
        username     = var.db_secret_username
        password     = var.db_secret_password
        host         = var.db_secret_host
        port         = var.db_secret_port
        service_name = var.db_secret_service_name
      })
      version_stages = var.db_version_stages
      policy         = local.db_secret_policy_json
      replicas       = var.db_replicas
    },
    {
      name                           = var.cognito_secret_name
      description                    = var.cognito_secret_description
      kms_key_id                     = module.kms.kms_keys[var.alias_secrets_api].arn
      recovery_window_in_days        = var.recovery_window_in_days
      force_overwrite_replica_secret = var.force_overwrite_replica_secret
      secret_string = jsonencode({
        COGNITO_REGION            = var.aws_region
        COGNITO_USER_POOL_ID      = module.cognito.user_pools["main"].id
        COGNITO_APP_CLIENT_ID     = local.cognito_client.id
        COGNITO_APP_CLIENT_SECRET = lookup(local.cognito_client, "client_secret", "")
      })
      version_stages = var.cognito_version_stages
      policy         = var.cognito_secret_policy
      replicas       = var.cognito_replicas
    }
  ]
}
# # ######################################################################
# # #  WAF - Amazon Web Application Firewall
# # ######################################################################

module "waf" {
  source        = "./Modules/WAF"
  project       = var.project
  environment   = var.environment
  domain        = var.domain
  resource_tags = var.resource_tags
  aws_region    = var.aws_region

  # Web ACL Configuration
  web_acl_config = [
    {
      name                       = var.waf_web_acl_name
      description                = var.waf_web_acl_description
      scope                      = var.waf_web_acl_scope
      default_action             = var.waf_default_action
      cloudwatch_metrics_enabled = var.waf_cloudwatch_metrics_enabled
      metric_name                = var.waf_metric_name
      sampled_requests_enabled   = var.waf_sampled_requests_enabled

      # Rules Configuration
      rules = [
        # Geo-Matching Rule - Allow specific countries (CO, US)
        {
          name           = "GeoMatchRule"
          priority       = 1
          action         = "allow"
          statement_type = "geo_match"

          # Geo Match specifics
          country_codes = var.waf_blocked_countries

          # Visibility Config
          cloudwatch_metrics_enabled = true
          metric_name                = "GeoMatchRule"
          sampled_requests_enabled   = true
        },

        # AWS Managed Rules - Common Rule Set
        {
          name           = "AWS-AWSManagedRulesCommonRuleSet"
          priority       = 10
          action         = "count"
          statement_type = "managed_rule_group"

          # Managed Rule Group specifics
          managed_rule_name = "AWSManagedRulesCommonRuleSet"
          vendor_name       = "AWS"
          excluded_rules    = var.waf_excluded_rules_common

          # Visibility Config
          cloudwatch_metrics_enabled = true
          metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
          sampled_requests_enabled   = true
        },

        # AWS Managed Rules - SQL Injection Rules
        {
          name           = "AWS-AWSManagedRulesSQLiRuleSet"
          priority       = 20
          action         = "count"
          statement_type = "managed_rule_group"

          # Managed Rule Group specifics
          managed_rule_name = "AWSManagedRulesSQLiRuleSet"
          vendor_name       = "AWS"

          # Visibility Config
          cloudwatch_metrics_enabled = true
          metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
          sampled_requests_enabled   = true
        },

        # Rate-Based Rule for Request Flooding
        {
          name           = "RateBasedRule"
          priority       = 30
          action         = "block"
          statement_type = "rate_based"

          # Rate-Based specifics
          rate_limit         = var.waf_rate_limit
          aggregate_key_type = "IP"

          # Visibility Config
          cloudwatch_metrics_enabled = true
          metric_name                = "RateBasedRule"
          sampled_requests_enabled   = true
        }
      ]

      # IP Set Rules Configuration 
      ip_sets = [] # Array vacío en lugar de null para evitar errores
    }
  ]

  # IP Set Configuration
  ip_set_config = []

  # Web ACL Association Configuration
  web_acl_association_config = var.waf_resource_arns != null && var.waf_resource_arns != "" ? [
    {
      web_acl_key  = var.waf_web_acl_name
      resource_arn = var.waf_resource_arns
    }
  ] : []

  # Logging Configuration
  logging_config = var.waf_log_destination_configs != null ? [
    {
      web_acl_key                   = var.waf_web_acl_name
      log_destination_configs       = var.waf_log_destination_configs
      redacted_fields_single_header = var.waf_redacted_fields
    }
  ] : []
}

# # ######################################################################
# # #  Glue Job - ETL job for data processing
# # ######################################################################
module "glue_job" {
  source = "./Modules/GLUE/Glue Job"
  # Variables de nombramiento
  project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags
  # Configuración que viene desde terraform.tfvars
  glue_config = var.glue_config
  # Variable para pasar las conexiones disponibles 
  available_connections = module.glue_connections.glue_connections
  depends_on            = [module.glue_connections]
}
# # # # ######################################################################
# # # # #  Glue Connetor - 
# # # # ######################################################################
module "glue_connections" {
  source = "./Modules/GLUE/Glue Connector"
  # Variables básicas del proyecto
  project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags

  physical_connection_requirements = {

    "extraction-oracle-db" = {

     subnet_id              = module.vpc.subnets[var.subnet_1a_name].id
     security_group_id_list = [module.security_groups.security_groups["extraction-gluejobs"].id]
     availability_zone      = "us-east-1a"
     secrets_manager_secret_arn = module.secrets_manager.secrets["database-credentials"].arn
   }
   "vpc-connectivity" = {

     subnet_id              = module.vpc.subnets[var.subnet_1a_name_second_project].id
     security_group_id_list = [module.security_groups.security_groups["extraction-gluejobs"].id]
     availability_zone      = "us-east-1a"
   }
 }

  # Configuración directa desde variable del tfvars
  glue_connections_config = var.glue_connections_config
}

# # ######################################################################
# # #  ECR Module - Elastic Container Registry
# # ######################################################################

module "ecr_repositories" {
  source = "./Modules/ECR"
  # Variables de nombramiento
  project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags

  # Pasar la clave KMS por defecto desde el módulo KMS
  default_kms_key_arn = module.kms.kms_keys["ecr"].arn

  # Configuración que viene desde .tfvars
  ecr_config = var.ecr_config
}

# # ######################################################################
# # #  ELB  - Elastic Load Balancing
# # ######################################################################
module "network_load_balancers" {
  source = "./Modules/ELB"
  # Variables de nombramiento
  project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags
  # Configuración que viene desde .tfvars
  lb_config = var.lb_config
  dynamic_subnets = [
    module.vpc.subnets[var.subnet_1a_name_second_project].id,
    module.vpc.subnets[var.subnet_1b_name_second_project].id
  ]
  dynamic_vpc_id = module.vpc.id
  security_groups_map = {
    "prices-nlb" = module.security_groups.security_groups["prices-nlb"].id
    # Puedes agregar más security groups aquí según necesites
  }
}

# # ######################################################################
# # #  ECS - Elastic Container Service 
# # ######################################################################
module "ecs_clusters" {
  source = "./Modules/ECS/Ecs Cluster"
  # Variables requeridas
  project                 = var.project
  domain                  = var.domain
  environment             = var.environment
  resource_tags           = var.resource_tags
  service_discovery_alias = var.service_discovery_alias
  vpc_id                  = module.vpc.id
  # Configuración desde terraform.tfvars (sin modificaciones)
  ecs_config = var.ecs_config
  # Dependencias
  depends_on = [module.vpc]
}
# # ######################################################################
# # #  ECS Services - Elastic Container Service 
# # ######################################################################
module "ecs_services" {
  source = "./Modules/ECS/Ecs Service"
  # Variables básicas
  project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags
  # Configuración de servicios
  ecs_services = var.ecs_services
  # Subnets dinámicas
  dynamic_subnets = [
    module.vpc.subnets[var.subnet_1a_name_second_project].id,
    module.vpc.subnets[var.subnet_1b_name_second_project].id
  ]
  security_groups_map = { # Puedes agregar más security groups aquí según necesites
    "materials-ecs"        = module.security_groups.security_groups["materials-ecs"].id
    "notes-ecs"            = module.security_groups.security_groups["notes-ecs"].id
    "prices-ecs"           = module.security_groups.security_groups["prices-ecs"].id
    "priceTagSegments-ecs" = module.security_groups.security_groups["priceTagSegments-ecs"].id
    "priceTagRules-ecs"    = module.security_groups.security_groups["priceTagRules-ecs"].id
    "priceHistory-ecs"     = module.security_groups.security_groups["priceHistory-ecs"].id
  }
  images_map = { # Puedes agregar más imágenes aquí según necesites
    "materials-api"        = module.ecr_repositories.ecr_repository_urls["materials-api"]
    "notes-api"            = module.ecr_repositories.ecr_repository_urls["notes-api"]
    "prices-api"           = module.ecr_repositories.ecr_repository_urls["prices-api"]
    "priceTagSegments-api" = module.ecr_repositories.ecr_repository_urls["pricetagssegments-api"]
    "priceTagRules-api"    = module.ecr_repositories.ecr_repository_urls["pricetagsrules-api"]
    "priceHistory-api"     = module.ecr_repositories.ecr_repository_urls["priceshistory-api"]
  }
  # *** NUEVO: Target Groups dinámicos ***
  target_groups_map = module.network_load_balancers.target_group_arns
  parameters_map = { # Puedes agregar más parámetros aquí según necesites 
    # Parameter store para services de Materials
    "materials_api_table" = {
      name = module.parameter_store.parameter_names["materials_api_table"]
      arn  = module.parameter_store.parameter_arns["materials_api_table"]
    }
    "materials_api_port" = {
      name = module.parameter_store.parameter_names["materials_api_port"]
      arn  = module.parameter_store.parameter_arns["materials_api_port"]
    }
    # Parameter store para services de Notes
    "notes_api_table" = {
      name = module.parameter_store.parameter_names["notes_api_table"]
      arn  = module.parameter_store.parameter_arns["notes_api_table"]
    }
    "notes_api_port" = {
      name = module.parameter_store.parameter_names["notes_api_port"]
      arn  = module.parameter_store.parameter_arns["notes_api_port"]
    }
    "notes_api_url_materials" = {
      name = module.parameter_store.parameter_names["notes_api_url_materials"]
      arn  = module.parameter_store.parameter_arns["notes_api_url_materials"]
    }
    # Parameter store para services de Prices
    "prices_api_table" = {
      name = module.parameter_store.parameter_names["prices_api_table"]
      arn  = module.parameter_store.parameter_arns["prices_api_table"]
    }
    "prices_api_port" = {
      name = module.parameter_store.parameter_names["prices_api_port"]
      arn  = module.parameter_store.parameter_arns["prices_api_port"]
    }
    "prices_api_url_materials" = {
      name = module.parameter_store.parameter_names["prices_api_url_materials"]
      arn  = module.parameter_store.parameter_arns["prices_api_url_materials"]
    }
    "prices_api_url_notes" = {
      name = module.parameter_store.parameter_names["prices_api_url_notes"]
      arn  = module.parameter_store.parameter_arns["prices_api_url_notes"]
    }
    "prices_api_url_priceTagRules" = {
      name = module.parameter_store.parameter_names["prices_api_url_priceTagRules"]
      arn  = module.parameter_store.parameter_arns["prices_api_url_priceTagRules"]
    }
    "prices_api_url_priceTagSegments" = {
      name = module.parameter_store.parameter_names["prices_api_url_priceTagSegments"]
      arn  = module.parameter_store.parameter_arns["prices_api_url_priceTagSegments"]
    }
    # Parameter store para services de priceTagsSegments
    "priceTagsSegments_api_table" = {
      name = module.parameter_store.parameter_names["priceTagsSegments_api_table"]
      arn  = module.parameter_store.parameter_arns["priceTagsSegments_api_table"]
    }
    "priceTagsSegments_api_port" = {
      name = module.parameter_store.parameter_names["priceTagsSegments_api_port"]
      arn  = module.parameter_store.parameter_arns["priceTagsSegments_api_port"]
    }
    "priceTagsSegments_api_url" = {
      name = module.parameter_store.parameter_names["priceTagsSegments_api_url"]
      arn  = module.parameter_store.parameter_arns["priceTagsSegments_api_url"]
    }
    # Parameter store para services de priceTagsRules
    "priceTagsRules_api_table" = {
      name = module.parameter_store.parameter_names["priceTagsRules_api_table"]
      arn  = module.parameter_store.parameter_arns["priceTagsRules_api_table"]
    }
    "priceTagsRules_api_port" = {
      name = module.parameter_store.parameter_names["priceTagsRules_api_port"]
      arn  = module.parameter_store.parameter_arns["priceTagsRules_api_port"]
    }
    # Parameter store para services de pricehistory
    "pricesHistory_api_table" = {
      name = module.parameter_store.parameter_names["pricesHistory_api_table"]
      arn  = module.parameter_store.parameter_arns["pricesHistory_api_table"]
    }
    "pricesHistory_api_port" = {
      name = module.parameter_store.parameter_names["pricesHistory_api_port"]
      arn  = module.parameter_store.parameter_arns["pricesHistory_api_port"]
    }
    "pricesHistory_api_url_materials" = {
      name = module.parameter_store.parameter_names["pricesHistory_api_url_materials"]
      arn  = module.parameter_store.parameter_arns["pricesHistory_api_url_materials"]
    }
    "pricesHistory_api_url_notes" = {
      name = module.parameter_store.parameter_names["pricesHistory_api_url_notes"]
      arn  = module.parameter_store.parameter_arns["pricesHistory_api_url_notes"]
    }
    "pricesHistory_api_url_priceTagRules" = {
      name = module.parameter_store.parameter_names["pricesHistory_api_url_priceTagRules"]
      arn  = module.parameter_store.parameter_arns["pricesHistory_api_url_priceTagRules"]
    }
    "pricesHistory_api_url_priceTagSegments" = {
      name = module.parameter_store.parameter_names["pricesHistory_api_url_priceTagSegments"]
      arn  = module.parameter_store.parameter_arns["pricesHistory_api_url_priceTagSegments"]
    }
  }
  # Dependencias - los servicios necesitan que los clusters existan
  depends_on = [module.ecs_clusters]
}

# # ######################################################################
# # #  Parameter Store - AWS Systems Manager Parameter Store
# # ######################################################################
module "parameter_store" {
  source = "./Modules/Parameter Store"
  # Variables de nombramiento
  project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags
  # Configuración que viene desde terraform.tfvars
  parameter_store_config = var.parameter_store_config
}
# # ######################################################################
# # #  Step Functions - AWS Step Functions State Machines
# # ######################################################################
module "step_function_state_machines" {
  source = "./Modules/Step Functions"
  # Variables de nombramiento
  project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags
  # Configuración que viene desde terraform.tfvars
  step_function_config = var.step_function_config
  # Dependencias - los servicios necesitan que los clusters existan
  depends_on = [module.s3]
}
