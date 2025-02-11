terraform {
  backend "s3" {
    bucket  = "devops-course-bucket"
    key     = "terraform/state.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
