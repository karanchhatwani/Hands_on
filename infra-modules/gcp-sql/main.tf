resource "google_sql_database" "main" {
  name     = "main1"
  instance = google_sql_database_instance.main_primary.name
}
resource "google_sql_database_instance" "main_primary" {
  name             = "main1"
  database_version = "MYSQL_8_0"
  deletion_protection = false
  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = 10  # 10 GB is the smallest disk size
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_vpc
    }
    
  }
}
resource "google_sql_user" "db_user" {
  name     = "Karan"
  instance = google_sql_database_instance.main_primary.name
  password = "Karan"
}