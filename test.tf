provider "aws"{
    region ="us-east-2"
    access_key = ""
    secret_key = ""
}
resource "aws_security_group"  "connect-ssh-http" {
    name = "connector"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
         from_port  = 0
         to_port    = 0
         protocol   = "-1"
         cidr_blocks = ["0.0.0.0/0"]
   }
 }
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAnr4+oTxLZPnqnijEv2DyHLRWRBUcey7dU8CT1WBuDxnshfD7Pdq1VZzNLugklTrJUPiKFbo1rjXmMg07APQQDxq4H0tEsdYgx1kq7qS99HS6GTLZNXTcT2T3uLV3XRRu+D/NFXDHo1i6wiGacTWDyVtzulIqREFj8QgeWTKYvsU5z79bgEw0wV6SUxl234qGoPyyoolNcJLvT52bRX1lmIsA4B+dv5ZhSOPR8fqf0wWHhsSr+6QsOXzv6iYJUcl+q8uin5dodXIMZIGRa8cf3E5KkjGUsl8kRNGX5XQitjhACRUoObdCs6kWQSX6Rh9haQWFm+JArLVaSFMamlRFlQ== rsa-key-20200802"

}
resource "aws_instance" "first" {
    ami             = "ami-000e7ce4dd68e7a11"
    instance_type   = "t2.micro"
    key_name        = "deployer-key"
    security_groups = ["${aws_security_group.connect-ssh-http.name}"]
 
  tags = {
    Name = "first_instance"
   }
 
}

