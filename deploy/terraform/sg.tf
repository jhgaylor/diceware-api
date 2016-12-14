# Note: sg rules are particularly hard to incapsulate within a module because lookup(element(listOfMaps)) fails. it has to be a "flat map" - could hack around it but its ugly
resource "aws_security_group_rule" "app" {
  security_group_id = "${module.diceware-api.app-sg-id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
