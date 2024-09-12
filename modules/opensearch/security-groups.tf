# Security groups of the cluster
resource "aws_security_group" "vpc_enabled" {
  #checkov:skip=CKV2_AWS_5: checks being trigger because the cluster is not attached to a VPC
  count       = var.vpc_enabled ? 1 : 0
  name        = "${var.domain}-sg"
  description = "The security group attached to Opensearch"
  vpc_id      = var.vpc_id
  tags        = var.tags

  #checkov:skip=CKV2_AWS_5: checks being trigger because the cluster is not attached to a VPC
  # TODO: Remove this when deploying to prod
}

# Security Group for the lambda
resource "aws_security_group" "es-loader-sg" {
  #checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  name        = "es-loader-sg"
  description = "Allow traffic for select subnets"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

# Egress rules here below
# ------------------------------

resource "aws_security_group_rule" "subnet_egress" {
  count             = var.vpc_enabled == true ? 1 : 0
  type              = "egress"
  description       = "egress to subnet of opensearch cluster "
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [for subnet in data.aws_subnet.selected : subnet.cidr_block]
  security_group_id = aws_security_group.es-loader-sg.id
}

resource "aws_security_group_rule" "vpce-s3-access" {
  count             = var.vpc_enabled == true ? 1 : 0
  description       = "give lambda access to s3"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.s3.id]
  security_group_id = aws_security_group.es-loader-sg.id
}

resource "aws_security_group_rule" "outbound_all" {
  count                    = var.vpc_enabled == true ? 1 : 0
  description              = "Allow all outbound traffic"
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "all"
  security_group_id        = aws_security_group.vpc_enabled[0].id
  cidr_blocks              = ["0.0.0.0/0"]
}

# Ingress rules below
# ------------------------------

resource "aws_security_group_rule" "https_access_es_loader" {
  count                    = var.vpc_enabled == true ? 1 : 0
  description              = "Give lambda access to oss"
  type                     = "ingress"
  source_security_group_id = aws_security_group.es-loader-sg.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vpc_enabled[0].id

}

resource "aws_security_group_rule" "https_access_allowed_cidrs" {
  count             = var.vpc_enabled == true ? 1 : 0
  type              = "ingress"
  from_port         = 443
  description       = "Allow ingress traffic to webserver port"
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidrs
  security_group_id = aws_security_group.vpc_enabled[0].id
}

resource "aws_security_group_rule" "logstash_access_433" {
  count             = var.vpc_enabled == true ? 1 : 0
  type              = "ingress"
  from_port         = 443
  description       = "Allow access from the onpremise logstash server (ICTCF-1682)"
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.108.5.20/32"]
  security_group_id = aws_security_group.vpc_enabled[0].id
}

resource "aws_security_group_rule" "logstash_access_9200" {
  count             = var.vpc_enabled == true ? 1 : 0
  type              = "ingress"
  from_port         = 9200
  description       = "Allow access from the onpremise logstash server (ICTCF-1682)"
  to_port           = 9200
  protocol          = "tcp"
  cidr_blocks       = ["10.108.5.20/32"]
  security_group_id = aws_security_group.vpc_enabled[0].id
}
