provider "google" {
  project = var.project_id
  region  = var.region
}

resource "random_password" "db_password" {
  length  = 24
  special = true
}

resource "google_sql_database_instance" "postgres" {
  name             = var.database_instance_name
  database_version = "POSTGRES_16"
  region           = var.region

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = 10
    disk_type         = "PD_SSD"

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "cloud-run"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_database" "default" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "default" {
  name     = var.database_user
  instance = google_sql_database_instance.postgres.name
  password = random_password.db_password.result
}

resource "google_cloud_run_v2_service" "app" {
  name     = var.service_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }

    containers {
      image = var.image

      ports {
        container_port = 8080
      }

      env {
        name  = "SECRET_KEY"
        value = var.secret_key
      }

      env {
        name  = "DEBUG"
        value = "False"
      }

      env {
        name  = "ALLOWED_HOSTS"
        value = "*"
      }

      env {
        name  = "CSRF_TRUSTED_ORIGINS"
        value = "https://${var.service_name}-${var.project_id}.a.run.app"
      }

      env {
        name  = "PORT"
        value = "8080"
      }

      env {
        name  = "DATABASE_URL"
        value = "postgresql://${var.database_user}:${random_password.db_password.result}@/${var.database_name}?host=/cloudsql/${google_sql_database_instance.postgres.connection_name}"
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

output "service_url" {
  value = google_cloud_run_v2_service.app.uri
}

output "database_connection_name" {
  value = google_sql_database_instance.postgres.connection_name
}
