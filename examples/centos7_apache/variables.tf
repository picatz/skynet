variable "allow_ip" {
  description = "Allow the given IP address CIDR block access to the instance."
  default     = ""
}

variable "aws_access_key" {
  description = "Used to sign programmatic requests that you make to AWS if you use the AWS SDKs, REST, or Query API operations."
  default     = ""
}


variable "aws_secret_key" {
  description = "Secret used to sign programmatic requests that you make to AWS if you use the AWS SDKs, REST, or Query API operations."
  default     = ""
}

variable "aws_region" {
  description = "Region to run the EC2 instance in."
  default     = "us-east-1a"
}
