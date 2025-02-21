resource "aws_db_instance" "flask_db" {
  identifier             = "flask-mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  publicly_accessible    = false
  multi_az               = false
  username               = "admin"
  password               = "yourpassword" # Use AWS Secrets Manager in production
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.private1.id,  # ✅ Terraform-managed subnets
    aws_subnet.private2.id
  ]
}
