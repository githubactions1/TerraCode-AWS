provider "aws" {
    access_key = "AKIAS2IWAZO3SP6UCS6A"
    secret_key = "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"
    region = "us-east-1"
}

resource "aws_vpc" "vpc" {
    cidr_block = "192.168.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "Testing-vpc"
    }
}

resource "aws_subnet" "Pub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "192.168.1.0/24"
    tags = {
           Name = "Public"
    }
}

resource "aws_subnet" "Pri" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "192.168.10.0/24"
    tags = {
        Name = "Private"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_nat_gateway" "ngw" {
    subnet_id = "aws_subnet.pri.id"
    tags = {
        Name = "NAT"
    }
}

resource "aws_route_table" "rt1" {
    vpc_id = aws_vpc.vpc.id
    route {
       cidr_block = "192.168.1.0/24"
       gateway_id = aws_internet_gateway.igw.id
   }
   tags = {
    Name = "custom"
   }
}

resource "aws_route_table" "rt2" {
    vpc_id = aws_vpc.vpc.id
    route {
       cidr_block = "192.168.10.0/24"
       gateway_id = aws_nat_gateway.ngw.id
   }
   tags = {
    Name = "main"
   }
}

resource "aws_route_table_association" "asc_1" {
      subnet_id = aws_subnet.Pub.id
      route_table_id = aws_route_table.rt1.id   
}

resource "aws_route_table_association" "asc_2" {
      subnet_id = "aws_subnet.pri.id"
      route_table_id = aws_route_table.rt2.id   
}

resource "aws_security_group" "secgro" {
          name = "first-SG" 
          ingress {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = [aws_vpc.vpc.cidr_block]
         }
         egress {
            from_port = 0
            to_port = 0
            protocol = "-1"
         } 
         tags = {
            Name = "first-SG"
         }       
}

