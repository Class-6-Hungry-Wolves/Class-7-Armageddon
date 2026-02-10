resource "google_compute_health_check" "nihonmachi_hc01" {
  name   = "nihonmachi-hc01"

  https_health_check {
    port = 443
    request_path = "/health"
  }
}

resource "google_compute_backend_service" "nihonmachi_backend01" {
  name                  = "nihonmachi-backend01"
  protocol              = "HTTPS"
  port_name             = "https"
  health_checks         = [google_compute_health_check.nihonmachi_hc01.id]
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = google_compute_region_instance_group_manager.nihonmachi_mig01.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
  }
}

resource "google_compute_url_map" "nihonmachi_urlmap01" {
  name   = "nihonmachi-urlmap01"
  default_service = google_compute_backend_service.nihonmachi_backend01.id
}

resource "google_compute_managed_ssl_certificate" "nihonmachi_cert01" {
  name = "nihonmachi-cert01"

  managed {
    domains = ["example.com"]
  }
}


resource "google_compute_target_https_proxy" "nihonmachi_httpsproxy01" {
  name   = "nihonmachi-httpsproxy01"
  url_map = google_compute_url_map.nihonmachi_urlmap01.id
  ssl_certificates = [google_compute_managed_ssl_certificate.nihonmachi_cert01.id]
}

resource "google_compute_global_forwarding_rule" "nihonmachi_fr01" {
  name                  = "nihonmachi-fr01"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_protocol           = "TCP"
  port_range            = "443"
  target                = google_compute_target_https_proxy.nihonmachi_httpsproxy01.id
}