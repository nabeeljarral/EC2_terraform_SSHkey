



resource "aws_instance" "web" {
  ami                         = "ami-04b70fa74e45c3917"
  instance_type               = "t2.micro"
  key_name                    = "devops_key"
  subnet_id                   = aws_subnet.staging.id
  vpc_security_group_ids      = [aws_security_group.staging_sg.id]
  associate_public_ip_address = true
  user_data                   = <<-EOF
              #!/bin/bash
              # Update the package list
              sudo apt update -y
              
              # Install Nginx
              sudo apt install -y nginx

              # Add PHP repository
              sudo apt update -y

              # Install PHP 8.2 and FPM
              sudo apt install -y php8.2 php8.2-fpm php8.2-mysql

              # Configure PHP-FPM to use UNIX socket
              sudo sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 127.0.0.1:9000/' /etc/php/8.2/fpm/pool.d/www.conf
              sudo systemctl restart php8.2-fpm

              # Install MySQL Server
              sudo apt install -y mysql-server
              sudo systemctl start mysql
              sudo systemctl enable mysql

              # Configure Nginx to use PHP Processor
              sudo tee /etc/nginx/sites-available/default > /dev/null <<EOL
              server {
                  listen 80 ;
                  listen [::]:80 ;
                  
                  root /var/www/html;
                  index index.php index.html index.htm;

                  server_name _;

                  location / {
                      try_files \$uri \$uri/ =404;
                  }

                  location ~ \.php$ {
                      include snippets/fastcgi-php.conf;
                      fastcgi_pass 127.0.0.1:9000;
                  }

                  location ~ /\.ht {
                      deny all;
                  }
              }
              EOL

              sudo systemctl restart nginx
              EOF




  tags = {
    Name = "${local.staging_env}-webserver"
  }
}

resource "aws_eip" "elastic_ip" {
  instance   = aws_instance.web.id
  depends_on = [aws_instance.web]
}



output "instance_ip" {
  value = aws_instance.web.public_ip
}


