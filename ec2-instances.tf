# ------------ input -------------------
variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-west-2"
}

variable "realm" {
    description = "The logical group that all of the infrastructure belongs to. Similar idea to an AWS stack."
    default = "Asgard Lite Testing" 
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
    default = "Consul Cluster" 
}

variable "managed_by" {
    description = "The tool that manages this resource."
    default = "Terraform" 
}

variable "key_name" {
    description = "The name of the SSH key to use."
    default = "asgard-lite-test" 
}

variable "server_user_data" {
    description = "The path to the file containing the EC2 user data."
    default = "user-data/touch.txt" 
}

variable "instance_type" {
    description = "The type of EC2 instance to spin up."
    default = "t2.micro" 
}

variable "docker_security_group" {
    description = "Security group applicable to instances hosting Docker engines."
    default = "sg-d7f480b3" 
}

variable "aws_amis" {
    description = "AMI to build the instances from."
    default = {
        us-east-1      = ""
        us-west-1      = ""
        us-west-2      = "ami-dab144ba"
        eu-west-1      = ""
        eu-central-1   = ""
        sa-east-1      = ""
        ap-southeast-1 = ""
        ap-southeast-2 = ""
        ap-northeast-1 = ""
    }
}

# ------------ resources -------------------

module "alpha" {
    source = "github.com/kurron/terraform-modules/aws/instance/well-known"
    name = "Alpha Consul Server"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"

    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    security_groups = "${var.docker_security_group}"
    ebs_optimized = false
    user_data = "${var.server_user_data}"
    private_ip = "10.0.2.200"
    subnet_id = "subnet-0ebf9e6b"
}

module "bravo" {
    source = "github.com/kurron/terraform-modules/aws/instance/well-known"
    name = "Bravo Consul Server"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"

    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    security_groups = "${var.docker_security_group}"
    ebs_optimized = false
    user_data = "${var.server_user_data}"
    private_ip = "10.0.0.200"
    subnet_id = "subnet-7181c606"
}

module "Charlie" {
    source = "github.com/kurron/terraform-modules/aws/instance/well-known"
    name = "Charlie Consul Server"
    realm = "${var.realm}"
    purpose = "${var.purpose}"
    managed_by = "${var.managed_by}"

    image_id = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"
    security_groups = "${var.docker_security_group}"
    ebs_optimized = false
    user_data = "${var.server_user_data}"
    private_ip = "10.0.4.200"
    subnet_id = "subnet-0c20be55"
}

