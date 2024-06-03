provider "aws" {
  region = "us-west-2"
}

# Define resources (EC2 instance)
resource "aws_instance" "app_server" {
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = "t2.micro"
  tags = {
    Name = "app_server"
  }

  # Use user data to install dependencies and set up environment
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nodejs npm python3 python3-pip

              # Clone repositories
              git clone https://github.com/your_nextjs_app.git /home/ubuntu/nextjs_app
              git clone https://github.com/your_django_app.git /home/ubuntu/django_app

              # Install Next.js dependencies
              cd /home/ubuntu/nextjs_app
              npm install

              # Install Django dependencies
              cd /home/ubuntu/django_app
              pip3 install -r requirements.txt

              # Run Django migrations
              python3 manage.py migrate

              # Start Next.js and Django servers
              nohup npm --prefix /home/ubuntu/nextjs_app run dev &
              nohup python3 /home/ubuntu/django_app/manage.py runserver 0.0.0.0:8000 &
              EOF
}

# Define outputs
output "app_server_ip" {
  value = aws_instance.app_server.public_ip
}
