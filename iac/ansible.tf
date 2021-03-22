variable "students" {
    description = "A list of all students participating in the TSBE CC module."
    default = {
        "tg" = 1
        "bl" = 2
        "cg" = 3
        "ci" = 4
        "ff" = 5
        "lg" = 6
        "ms" = 7
        "mw" = 8
        "ps" = 9
        "rc" = 10
        "sg" = 11
        "sl" = 12
        "vm" = 13
    }
}

// Machine for each student in the list.
resource "google_compute_instance" "student" {
    for_each = var.students

    name         = "vm-${each.key}"
    machine_type = "e2-micro"
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
    machine_type = "e2-small"
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