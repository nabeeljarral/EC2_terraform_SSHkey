Terraform configuration does the following:

Creates a VPC with a CIDR block of 10.0.0.0/16.
Creates a public subnet with a CIDR block of 10.0.1.0/24.
Creates a security group that allows SSH access from any IP address (0.0.0.0/0).
Creates a key pair using the public key file my-key-pair.pub.
Creates an EC2 instance within the VPC, using the security group and key pair you created.
Creates an Elastic IP address and associates it with the EC2 instance.
Creates an S3 bucket for storing the Terraform state file.
Configures the Terraform backend to use the S3 bucket for state storage.
