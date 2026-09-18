output "cloud_run_url" {
  description = "URL pública do serviço Cloud Run"
  value       = google_cloud_run_v2_service.app.uri
}

output "cloud_sql_instance" {
  description = "Nome da instância do Cloud SQL"
  value       = google_sql_database_instance.postgres.name
}

output "cloud_sql_connection_name" {
  description = "Connection name do Cloud SQL para uso na aplicação"
  value       = google_sql_database_instance.postgres.connection_name
}
