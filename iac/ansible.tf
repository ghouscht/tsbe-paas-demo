variable "students" {
    description = "A list of all students participating in the TSBE CC module."
    default = {
        "tg" = 1
        "bl" = 2
        "gc" = 3
        "rc" = 4
        "ic" = 5
        "ff" = 6
        "gl" = 7
        "sm" = 8
        "wm" = 9
        "sp" = 10
        "gs" = 11
        "ls" = 12
        "mv" = 13
    }
}

// Machine for each student in the list.
resource "google_compute_instance" "student" {
    for_each = var.students

    name         = "vm-${each.key}"
    machine_type = "f1-micro"
    zone         = "europe-west6-a"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    labels = {
        "student" = each.key
    }

    metadata = {
        ssh-keys = "student:${file("id_rsa.pub")}"
    }

    metadata_startup_script = "echo '*** ${each.key} ***' | sudo tee /etc/motd"

    network_interface {
        network = "default"
    }
}

// A variable for extracting the internal IP address of the student instances.
output "students" {
    value = {
        for instance in google_compute_instance.student:
        instance.labels.student => instance.network_interface.0.network_ip
    }
}

// Machine we use as an ssh gateway. Quota for external IPs is limited to 8 and we got more students, so we use this machine as gateway.
resource "google_compute_instance" "gateway" {
    name         = "gateway"
    machine_type = "f1-micro"
    zone         = "europe-west6-a"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-10"
        }
    }

    metadata = {
        ssh-keys = "student:${file("id_rsa.pub")}"
    }

    metadata_startup_script = "echo '*** GATEWAY ***' | sudo tee /etc/motd"

    network_interface {
        network = "default"
        access_config {
        // Include this section to give the VM an external ip address
        }
    }
}

// A variable for extracting the public IP address of the gateway instance.
output "gateway" {
    value = google_compute_instance.gateway.network_interface.0.access_config.0.nat_ip
}