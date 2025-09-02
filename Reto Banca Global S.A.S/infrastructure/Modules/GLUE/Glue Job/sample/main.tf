module "glue_job" {
  source = "./Modules/Glue Job"

  # Variables de nombramiento
   project       = var.project
  domain        = var.domain
  environment   = var.environment
  resource_tags = var.resource_tags
  
  # Configuración que viene desde terraform.tfvars
  glue_config = var.glue_config
}
