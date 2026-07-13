# security group

resource "aws_security_group" "alb_security_group" {
  vpc_id = var.vpc_id
  tags = var.tags # etiqueta que tendrá el recurso (lo recibimos de los entornos)
  # trafico entrante desde el puerto 80


  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

# balanceador de trafico
resource "aws_alb" "application_load_balancer" {
  name = "${lookup(var.tags, "environment", "prod")}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_security_group.id]
  subnets = var.subnet_ids
  tags = var.tags
}


# listener, todo lo que llega, lo envia al target group

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port = 80
  protocol = "HTTP"
  tags = var.tags

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

# registro de las instancias que van a recibir el trafico (lista de destinos/servers)
resource "aws_lb_target_group" "target_group" {
  name = "${lookup(var.tags, "environment", "prod")}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  tags = var.tags
  
  # el health check sirve para que el lb le haga requests periodicos a las instancias para verificar que funcionan
  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 30
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

# registro de las instancias en el target_group, sin esto, el target group está vacio
resource "aws_lb_target_group_attachment" "this" {
  for_each = var.instance_ids

  target_group_arn = aws_lb_target_group.target_group.arn
  target_id = each.value
  port = 80
}