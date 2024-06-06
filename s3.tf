terraform {
  backend "s3" {
    bucket  = "terraform-staginghb"
    key     = "e/tf_labs/lab1/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

}
