# Rails HelloWorld
This repository will fulfill the `instructions.txt` requirements.  Namely, that a single command can be used to launch an instance and run a web application.

### Pre-requisites
1. Terraform
2. AWS cli client with credentials configured
3. For ssh access to the generated instance, access to the private key that corresponds to  `resources/ro-web.pub` public key.  You can generate a new one.

### Usage
From within this repository run the build and launch script:
```
./build-and-launch.sh
```

Terraform will create an AWS "Default VPC" with 2 public subnets, a public "key pair" for launching instances, a web server security group, and an instance with a rails installation and boilerplate rails app served on port 80.

The instance is based on a community Ubuntu 16.04 AMI.  A `user_data` script is used to install ruby, rails, initialize a boilerplate rails app and run it.
