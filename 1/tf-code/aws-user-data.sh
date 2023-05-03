#!/bin/bash

sudo yum update -y
# Install Apache web server and SSL module
sudo yum install httpd mod_ssl -y

# Start Apache service and enable it to start on boot
sudo systemctl start httpd
sudo systemctl enable httpd

# Configure virtual host for HTTP on port 8080
echo '<VirtualHost *:8080>
        DocumentRoot /var/www/html/
        <Directory /var/www/html/>
                AllowOverride All
                Require all granted
        </Directory>
</VirtualHost>' | sudo tee /etc/httpd/conf.d/http-test.conf

echo 'http-test.conf has been updated'

# Create index.html file in document root
echo "<html><body><h1>Hello, World!</h1></body></html>" > /var/www/html/index.html

echo 'index.html has been updated in the root'

# Create app directory and index.html file in app directory
mkdir /var/www/html/app
echo "<html><body><h1>Hello from the app directory!</h1></body></html>" > /var/www/html/app/index.html
echo "index.html has been updated in /app"
# Configure virtual host for HTTPS on port 8443
cat > /etc/httpd/conf.d/ssl-test.conf << EOF
<VirtualHost *:8443>
        DocumentRoot /var/www/html/
        <Directory /var/www/html/>
                AllowOverride All
                Require all granted
        </Directory>
        Alias /app /var/www/html/app
        <Directory /var/www/html/app>
                AllowOverride All
                Require all granted
        </Directory>
        SSLEngine on
        SSLCertificateFile /etc/pki/tls/certs/selfsigned.crt
        SSLCertificateKeyFile /etc/pki/tls/private/selfsigned.key
</VirtualHost>
EOF
export publcip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
cat > /etc/httpd/conf.d/http-redirect.conf << EOF
<VirtualHost *:8080>
        ServerName $publcip
        Redirect permanent / https://$publcip:8443/
</VirtualHost>
EOF

# Create self-signed SSL certificate
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/private/selfsigned.key -out /etc/pki/tls/certs/selfsigned.crt -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

sudo DOMAIN_NAME="localhost"

# Set the path for the private key and SSL certificate
sudo KEY_PATH="/etc/pki/tls/private/$DOMAIN_NAME.key"
sudo CERT_PATH="/etc/pki/tls/certs/$DOMAIN_NAME.crt"

# Generate the SSL certificate
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout $KEY_PATH \
-out $CERT_PATH \
-subj "/CN="

sudo cp /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.bak
sudo sed -i 's/SSLProtocol all -SSLv3/SSLProtocol -ALL +TLSv1 +TLSv1.1 +TLSv1.2/' /etc/httpd/conf.d/ssl.conf
sudo sed -i 's/SSLCertificateFile \/etc\/pki\/tls\/certs\/localhost.crt/SSLCertificateFile \/etc\/pki\/tls\/certs\/localhost.crt\nSSLCertificateKeyFile \/etc\/pki\/tls\/private\/localhost.key/' /etc/httpd/conf.d/ssl.conf
sudo sed -i 's/Listen 443/Listen 8443/' /etc/httpd/conf.d/ssl.conf
sudo sed -i 's/<VirtualHost _default_:443>/<VirtualHost _default_:8443>/' /etc/httpd/conf.d/ssl.conf

sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
sudo sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
sudo sed -i 's/DocumentRoot "\/var\/www\/html"/DocumentRoot "\/var\/www\/html"\nRewriteEngine On\nRewriteCond %{HTTPS} !=on\nRewriteRule ^\/?(.*) https:\/\/'"$publicip"':8443\/$1 [R,L]/' /etc/httpd/conf/httpd.conf

echo 'DocumentRoot "/var/www/html/app"' >> /etc/httpd/conf/httpd.conf
echo '<Directory "/var/www/html/app">' >> /etc/httpd/conf/httpd.conf
echo '    AllowOverride All' >> /etc/httpd/conf/httpd.conf
echo '    Require all granted' >> /etc/httpd/conf/httpd.conf
echo '</Directory>' >> /etc/httpd/conf/httpd.conf

# Restart Apache to apply changes
sudo systemctl restart httpd