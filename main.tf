# create bucket
resource "google_storage_bucket" "my-bucket" {
  name = "my_terraform_bucket_kshitiz"
  location = var.region
}
data "archive_file" "hello_zip" {
  type        = "zip"
  source_dir  = "./function"
  output_path = "./staging/function.zip"
}

resource "google_storage_bucket_object" "hello_zip" {
  name   = format("hello_%s.zip", data.archive_file.hello_zip.output_md5)
  bucket = google_storage_bucket.my-bucket.name
  source = data.archive_file.hello_zip.output_path
}
# create pub/sub topic
resource "google_pubsub_topic" "topic" {
  name = "terraform-topic"
}

# create function
resource "google_cloudfunctions_function" "function" {
  name        = "terraform-function"
  description = "My function"
  runtime     = "python37"

  available_memory_mb   = 128
  source_archive_bucket = "${google_storage_bucket.my-bucket.name}"   # interpolation referencing
  source_archive_object = "${google_storage_bucket_object.hello_zip.name}"   # interpolation referencing
  entry_point           = "hello_pubsub"

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource = "${google_pubsub_topic.topic.name}"  # interpolation referencing
  }
}