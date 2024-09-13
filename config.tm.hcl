globals "terraform" {
  version = "~>1.7"
}

globals "terraform" "backend" "s3" {
  region = "eu-west-1"
  bucket = "bac-terramate-demo-backend"
}
