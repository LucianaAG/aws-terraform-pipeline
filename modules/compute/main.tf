# definicion de un rol a la instancia y conexion a System Manager
# que es un servicio que nos permite conectarnos a la instancia sin claves SSH
resource "aws_iam_role" "ssm_role" {
  name = "${var.env}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# asignacion del rol a la instancia
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# cconexion de la instancia con System Manager
resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.env}-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

# data source para obtener la imagen de SO compatible con la arq de vm elegida

data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = [ "amazon" ]

    filter {
      name = "name"
      values = ["al2023-ami-*-x86_64"]
    }
}

resource "aws_instance" "server" {
  subnet_id              = var.subnet_id
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  tags                   = var.tags
}




