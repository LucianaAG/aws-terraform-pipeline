resource "aws_vpc" "internal_vpc" {
    cidr_block = var.vpc_cidr
}

# Creacion de las subnets publicas o privadas
resource "aws_subnet" "this" {
    for_each = var.subnets

    vpc_id = aws_vpc.internal_vpc.id
    cidr_block = each.value.cidr
}

# Definicion de la security group

resource "aws_security_group" "public_security_group" {
    vpc_id = aws_vpc.internal_vpc.id
    
    # trafico entrante SSH

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # trafico entrante HTTP

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # trafico saliente hacia cualquier puerto

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" # hacia cualquier puerto
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# definicion del Elastic IP para el ngw

resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.internal_vpc.id
}

# NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.this["public"].id
}

# Definicion de la route table publica

resource "aws_route_table" "public_rt"{
    vpc_id = aws_vpc.internal_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

}

# Definicion de la route table privada

resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.internal_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id  = aws_nat_gateway.ngw.id
    }

}

# Asociacion de la route table a las subnets

resource "aws_route_table_association" "public_rta" {
    for_each = var.subnets
    subnet_id = aws_subnet.this[each.key].id
    route_table_id = each.value.is_public ? aws_route_table.public_rt.id : aws_route_table.private_rt.id
}


