terraform {
  backend "s3" {
    bucket         = "rizk-statefile1"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "test"
  }
}
