terraform {
  backend "gcs" {
    bucket      = "class7armageddonstoragevvave"
    prefix      = "terraform/lab4A—japanmedical-test"
    credentials = "key.json"
  }
}