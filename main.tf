data "aws_vpc" "Anishvpc" {
  id=var.vpc_id
}

data "aws_availability_zones" "allAzs" {
  
}

resource "aws_subnet" "subnets" {
  vpc_id = data.aws_vpc.Anishvpc.id
  count = length(data.aws_availability_zones.allAzs.names)
  availability_zone = data.aws_availability_zones.allAzs.names[count.index]
  cidr_block = "10.0.${count.index+1}.0/24"
  tags = {
    "Name" = "${var.subnet_name_prefix} ${count.index + 1}"
  }
}


output "allazs"{
  value = data.aws_availability_zones.allAzs
}

