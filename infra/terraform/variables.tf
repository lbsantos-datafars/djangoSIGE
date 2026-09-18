variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região do GCP"
  type        = string
  default     = "southamerica-east1"
}

variable "service_name" {
  description = "Nome do serviço Cloud Run"
  type        = string
  default     = "djangosige"
}

variable "image" {
  description = "Imagem Docker para o Cloud Run"
  type        = string
}

variable "database_instance_name" {
  description = "Nome da instância do Cloud SQL"
  type        = string
  default     = "djangosige-db"
}

variable "database_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "sige"
}

variable "database_user" {
  description = "Usuário do banco PostgreSQL"
  type        = string
  default     = "sige"
}

variable "secret_key" {
  description = "Secret key do Django"
  type        = string
  sensitive   = true
}
