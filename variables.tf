variable "region" {
    description = "Region which instance will deploy"
    type = string
}

variable "availability_zone" {
    description = "Avaliability zone which instance will deploy"
    type = string
}

variable "ami" {
    description = "AMI which instance will run on"
    type = string
}

variable "bucket_name" {
    description = "Bucket name of S3 instance"
    type = string
}

variable "database_name" {
    description = "Maria DB database name"
    type = string
}

variable "database_user" {
    description = "Maria DB username"
    type = string
}

variable "database_pass" {
    description = "Maria DB password"
    type = string
}

variable "admin_user" {
    description = "Admin username"
    type = string
}

variable "admin_pass" {
    description = "Admin password"
    type = string
}

variable "key_name" {
    description = "Key pair name for instance"
    type = string
    default = ""
}