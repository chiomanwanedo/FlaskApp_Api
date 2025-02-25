resource "aws_instance" "api_server" {
  ami                    = "ami-091f18e98bc129c4e" # Replace with a valid AMI ID
  instance_type          = "t3.small"
  key_name               = "chioma_keypair"
  subnet_id              = aws_subnet.public1.id  # ✅ Terraform-managed subnet
  vpc_security_group_ids = [aws_security_group.api_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "APIServer"
  }
}

resource "aws_instance" "jenkins_server" {
  ami                    = "ami-091f18e98bc129c4e" # Replace with a valid AMI ID
  instance_type          = "t3.medium"
  key_name               = "chioma_keypair"
  subnet_id              = aws_subnet.public1.id  # ✅ Terraform-managed subnet
  vpc_security_group_ids = [aws_security_group.api_sg.id]
  associate_public_ip_address = true

  user_data = file("userdata_jenkins.sh") # Ensure this file exists

  tags = {
    Name = "JenkinsServer"
  }
}
