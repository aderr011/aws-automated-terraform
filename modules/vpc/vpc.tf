resource "aws_vpc" "ad_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name    = "ad_vpc"
    Project = "AD starter TF"
  }
}

resource "aws_internet_gateway" "ad_gw" {
  vpc_id = aws_vpc.ad_vpc.id
  tags = {
    Name    = "ad_gw"
    Project = "AD starter TF"
  }
}

resource "aws_eip" "ad_eip_1" {
  tags = {
    Name    = "ad_eip"
    Project = "AD starter TF"
  }
}
resource "aws_nat_gateway" "ad_nat_gw_1" {
  allocation_id = aws_eip.ad_eip_1.id
  subnet_id     = aws_subnet.ad_subnet_1.id
  tags = {
    Name    = "ad_nat_gw_1"
    Project = "AD starter TF"
  }
}
resource "aws_subnet" "ad_subnet_1" {
  vpc_id            = aws_vpc.ad_vpc.id
  cidr_block        = var.public_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "ad_subnet_1"
    Project = "AD starter TF"
  }
}

resource "aws_eip" "ad_eip_2" {
  tags = {
    Name    = "ad_eip_2"
    Project = "AD starter TF"
  }
}
resource "aws_nat_gateway" "ad_nat_gw_2" {
  allocation_id = aws_eip.ad_eip_2.id
  subnet_id     = aws_subnet.ad_subnet_1.id
  tags = {
    Name    = "ad_nat_gw_2"
    Project = "AD starter TF"
  }
}
resource "aws_subnet" "ad_subnet_2" {
  vpc_id            = aws_vpc.ad_vpc.id
  cidr_block        = var.public_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "ad_subnet_2"
    Project = "AD starter TF"
  }
}

resource "aws_subnet" "ad_private_subnet_1" {
  vpc_id            = aws_vpc.ad_vpc.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "ad_private_subnet_1"
    Project = "AD starter TF"
  }
}
resource "aws_subnet" "ad_private_subnet_2" {
  vpc_id            = aws_vpc.ad_vpc.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "ad_private_subnet_2"
    Project = "AD starter TF"
  }
}

resource "aws_route_table" "ad_pub_rt" {
  vpc_id = aws_vpc.ad_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ad_gw.id
  }
  tags = {
    Name    = "ad_pub_rt"
    Project = "AD starter TF"
  }
}
resource "aws_route_table" "ad_priv_rt_1" {
  vpc_id = aws_vpc.ad_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ad_nat_gw_1.id
  }
  tags = {
    Name    = "ad_priv_rt_1"
    Project = "AD starter TF"
  }
}
resource "aws_route_table" "ad_priv_rt_2" {
  vpc_id = aws_vpc.ad_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ad_nat_gw_2.id
  }
  tags = {
    Name    = "ad_priv_rt_2"
    Project = "AD starter TF"
  }
}

resource "aws_route_table_association" "ad_rt_association_1" {
  subnet_id      = aws_subnet.ad_subnet_1.id
  route_table_id = aws_route_table.ad_pub_rt.id
}
resource "aws_route_table_association" "ad_rt_association_2" {
  subnet_id      = aws_subnet.ad_subnet_2.id
  route_table_id = aws_route_table.ad_pub_rt.id
}
resource "aws_route_table_association" "ad_priv_rt_association_1" {
  subnet_id      = aws_subnet.ad_private_subnet_1.id
  route_table_id = aws_route_table.ad_priv_rt_1.id
}
resource "aws_route_table_association" "ad_priv_rt_association_2" {
  subnet_id      = aws_subnet.ad_private_subnet_2.id
  route_table_id = aws_route_table.ad_priv_rt_2.id
}