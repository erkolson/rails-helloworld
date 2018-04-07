# variable "aws_access_key" {}
# variable "aws_secret_key" {}

provider "aws" {
  region = "ap-southeast-2"
  # profile = "reactiveops"
  # access_key = "${var.aws_access_key}"
  # secret_key = "${var.aws_secret_key}"
}

# TODO: use a data resource
variable ami {
  default = "ami-2b12dc49"
}

# output .key_name
resource "aws_key_pair" "ro_web" {
  key_name = "ro-web"
  public_key = "${file("./resources/ro-web.pub")}"
}

###############################################################################
## V P C
###############################################################################
resource "aws_default_vpc" "default" {
    tags {
        Name = "Default VPC"
    }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${aws_default_vpc.default.id}"
}

###############################################################################
## S E C U R I T Y     G R O U P
###############################################################################
resource "aws_security_group" "web" {
  name = "web"
  description = "allow access to web servers"
  vpc_id = "${aws_default_vpc.default.id}"
}

resource "aws_security_group_rule" "web_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.web.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

###############################################################################
## I N S T A N C E
###############################################################################
resource "aws_instance" "web" {
  ami             = "${var.ami}"
  instance_type   = "t2.micro"
  subnet_id       = "${element(data.aws_subnet_ids.public.ids, 0)}"
  security_groups = [
    "${aws_security_group.web.id}"
  ]
  user_data       = "${file("install-init-run-rails.sh")}"
  associate_public_ip_address = true

  tags {
    Name = "Rails-HelloWorld"
  }
}
