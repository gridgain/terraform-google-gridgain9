# locals {
#   lb_scheme = "INTERNAL"
# }

# resource "google_compute_address" "nlb_ip" {
#   name         = "${var.name_prefix}-backend-service-ip"
#   address_type = "INTERNAL"
#   subnetwork   = google_compute_subnetwork.subnet[0].id
# }

# resource "google_compute_region_backend_service" "this" {
#   name     = "${var.name_prefix}-tcp-backend-service"
#   protocol = "TCP"
#   connection_draining_timeout_sec = 15

#   backend {
#     group = google_compute_region_instance_group_manager.this.instance_group
#     balancing_mode  = "CONNECTION"
#   }

#   # health_checks         = [google_compute_http_health_check.this.id]
#   health_checks         = [google_compute_region_health_check.this.id]
#   load_balancing_scheme = local.lb_scheme
# }

# resource "google_compute_region_health_check" "this" {
#   name = "${var.name_prefix}-tcp-healthcheck"
#   tcp_health_check {
#     port = 10300
#   }
# }

# resource "google_compute_forwarding_rule" "this" {
#   name                  = "${var.name_prefix}-fw"
#   load_balancing_scheme = local.lb_scheme
#   ip_protocol           = "TCP"
#   ip_address            = google_compute_address.nlb_ip.address
#   ports                 = ["3344", "10300"]
#   backend_service       = google_compute_region_backend_service.this.id
#   network               = google_compute_network.vpc[0].id
#   subnetwork            = google_compute_subnetwork.subnet[0].id
# }
