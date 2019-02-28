resource "aws_security_group" "ingress-all-test" {

name = "allow-all-sg"

vpc_id = "${aws_vpc.test-env.id}"

ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

from_port = 22
    to_port = 22
    protocol = "tcp"
  }

ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

from_port = 8001
    to_port = 8001
    protocol = "tcp"
  }

ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

from_port = 8005
    to_port = 8005
    protocol = "tcp"
  }

ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

from_port = 8050
    to_port = 8050
    protocol = "tcp"
  }

ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

from_port = 8000
    to_port = 8000
    protocol = "tcp"
  }

// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

}