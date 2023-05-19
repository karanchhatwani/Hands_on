resource "google_compute_instance" "web" {
  name = "web1"
  machine_type = "n1-standard-1"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2004-focal-v20230427"
    }
  }
  network_interface {
    subnetwork = var.private_subnet
    network_ip = var.private_vpc
    }
  metadata = {
    startup-script = <<-EOF
      #!/bin/bash

      sudo apt-get update
      sudo apt-get install -y apache2 php libapache2-mod-php

      echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php

      sudo systemctl start apache2
    EOF
  }
}