

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "webserver"
}


variable "instanc_type" {
  description = "intance type"
  type        = string
  default     = "t2.micro"
}


variable "instanc_ami" {
  description = "intance type"
  type        = string
  default     = "ami-04b70fa74e45c3917"
}


variable "instance_count" {
  description = "intance count"
  type        = number
  default     = "1"
}
