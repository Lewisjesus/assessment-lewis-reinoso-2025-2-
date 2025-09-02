## **🚀 Módulo Terraform para Glue jobs: cloudops-ref-repo-aws-glue_job-terraform**

## Descripción:

Este módulo de Terraform permite la creación y gestión de recursos para ejecutar trabajos de AWS Glue. El módulo configura:

- Un rol de IAM para la ejecución de Glue.
- Una política mínima de IAM y su correspondiente asignación.
- Un grupo de logs en CloudWatch para la observabilidad del trabajo.
- Trabajos de AWS Glue para distintos tipos: `glueetl`, `pythonshell` y `glueray`.

Y requiere previamnete la creación de:

- bucket_id: ID de un bucket de destino

  
Consulta CHANGELOG.md para la lista de cambios de cada versión. *Recomendamos encarecidamente que en tu código fijes la versión exacta que estás utilizando para que tu infraestructura permanezca estable y actualices las versiones de manera sistemática para evitar sorpresas.*

## Estructura del Módulo

El módulo cuenta con la siguiente estructura:

```bash
cloudops-ref-repo-aws-rds-terraform/
└── sample/
    ├── data.tf
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── terraform.auto.tfvars
    └── variables.tf
├── CHANGELOG.md
├── README.md
├── data.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── variables.tf
```

- Los archivos principales del módulo (`data.tf`, `main.tf`, `outputs.tf`, `variables.tf`, `locals.tf`) se encuentran en el directorio raíz.
- `CHANGELOG.md` y `README.md` también están en el directorio raíz para fácil acceso.
- La carpeta `sample/` contiene un ejemplo de implementación del módulo.


## Uso del Módulo:

```hcl
module "glue_job" {
  source = "module/glue_job"

  client         = "xxxx"
  project        = "xxxx"
  environment    = "xxxx"
  application    = "xxxx"
  functionality  = "xxxx"
  bucket_id      = "xxxx"
  job_type       = "xxxx"         # Puede ser "pythonshell", "glueetl" o "glueray"

  # Variables ejemplo para un tipo spark y ray
  glue_version      = "xxxx"  
  worker_type       = "xxxx"  
  number_of_workers = "xxxx"  
  job_language      = "xxxx"  
  runtime           = "xxxx"  

  #Variables ejemplo para un tipo pyhtonshell
  max_capacity      = "xxxx"  
  python_version    = "xxxx"  

  # Argumentos adicionales para default_arguments
  additional_default_arguments = {
    "--enable-glue-datacatalog" = "true"
  }
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.project"></a> [aws.project](#provider\_aws) | >= 4.31.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.glue_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy.glue_minimal_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.glue_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_cloudwatch_log_group.glue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_glue_job.glueetl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_job) | resource |
| [aws_glue_job.pythonshell](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_job) | resource |
| [aws_glue_job.glueray](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_job) | resource |



## 📌 Variables

| Variable                       | Tipo         | Predeterminado | Obligatorio | Descripción                                                                                                                  |
|--------------------------------|--------------|----------------|-------------|------------------------------------------------------------------------------------------------------------------------------|
| `client`                       | `string`     | —              | Sí          | Nombre del cliente.                                                                                                          |
| `project`                      | `string`     | —              | Sí          | Nombre del proyecto.                                                                                                         |
| `environment`                  | `string`     | —              | Sí          | Nombre del ambiente.                                                                                                         |
| `application`                  | `string`     | —              | Sí          | Nombre de la aplicación (por ejemplo, "glue").                                                                               |
| `functionality`                | `string`     | —              | Sí          | Nombre de la funcionalidad que desempeña el recurso.                                                                         |
| `bucket_id`                    | `string`     | —              | Sí          | Nombre del bucket S3 (puede ser el output del módulo S3 con el atributo `id`).                                               |
| `job_type`                     | `string`     | `glueetl`      | No          | Tipo de job: puede ser `pythonshell`, `glueetl` o `glueray`.                                                                 |
| `glue_version`                 | `string`     | `4.0`          | No          | Versión de AWS Glue a utilizar.                                                                                              |
| `worker_type`                  | `string`     | `G.1X`         | No          | Tipo de trabajador para el job de Glue.                                                                                      |
| `number_of_workers`            | `number`     | `2`            | No          | Número de trabajadores asignados al trabajo de Glue.                                                                         |
| `job_language`                 | `string`     | `python`       | No          | Lenguaje del trabajo de Glue (por ejemplo, `python`, `scala`, `pyspark`, `spark`).                                           |
| `max_capacity`                 | `number`     | `0.0625`       | No          | Capacidad máxima asignada al job para el tipo `pythonshell`.                                                                 |
| `python_version`               | `string`     | `3.9`          | No          | Versión de Python para trabajos de tipo `pythonshell`.                                                                       |
| `runtime`                      | `string`     | `Ray2.4`       | No          | Runtime para trabajos de tipo `glueray`.                                                                                     |
| `additional_default_arguments` | `map(string)`| `{}`           | No          | Mapa de argumentos adicionales para configurar el trabajo de Glue.                                                           |

### 📤 Outputs

| Output             | Tipo   | Descripción                                                                                                   |
|--------------------|--------|---------------------------------------------------------------------------------------------------------------|
| `glue_job_name`    | `string` | Nombre del trabajo de AWS Glue seleccionado, de acuerdo al tipo configurado (`glueetl`, `pythonshell` o `glueray`). |
| `glue_job_arn`     | `string` | ARN del trabajo de AWS Glue seleccionado.                                                                     |

