resource "google_sql_database_instance" "mattermost_db" {
  name = "${var.project_id}-mysql-${random_id.db_name_suffix.hex}"
  project = var.project_id
  database_version = "MYSQL_8_0"
  region = var.region
  deletion_protection = false

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = var.cloud_sql_tier

    disk_autoresize = false

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }

    maintenance_window {
      day = 7
      hour = 0
    }

    backup_configuration {
      enabled = true
      binary_log_enabled = true
      start_time = "02:00"
    }
  }
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "random_password" "db_admin_pw" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_password" "mmost_user_pw" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "google_sql_database" "mattermost" {
  name = "mattermost"
  instance = google_sql_database_instance.mattermost_db.name
  charset = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "root" {
  name = "root"
  instance = google_sql_database_instance.mattermost_db.name
  host = "%"
  password = random_password.db_admin_pw.result
}

resource "google_sql_user" "mmost" {
  name = "mmost"
  instance = google_sql_database_instance.mattermost_db.name
  host = "%"
  password = random_password.mmost_user_pw.result
}