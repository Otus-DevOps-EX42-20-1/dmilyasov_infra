resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  #  zone = "europe-west1-b"
  zone = var.zone
  tags = ["reddit-app"]

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }

  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }
  }

  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}
#  connection {
#    type  = "ssh"
#    host  = self.network_interface[0].access_config[0].nat_ip
#    user  = "appuser"
#    agent = false
#    # путь до приватного ключа
#    #    private_key = file("~/.ssh/appuser")
#    private_key = file(var.private_key_path)
#  }
#}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_nginx" {
  name = "allow-nginx-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
