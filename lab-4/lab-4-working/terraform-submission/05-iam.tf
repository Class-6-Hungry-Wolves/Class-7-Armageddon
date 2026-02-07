resource "google_service_account" "nihonmachi_sa01" {
  account_id   = "nihonmachi-sa01"
  display_name = "nihonmachi-sa01"
}

resource "google_project_iam_member" "nihonmachi_secret_accessor01" {
  project = var.gcp_project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.nihonmachi_sa01.email}"
}