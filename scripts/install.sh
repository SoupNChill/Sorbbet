#!/bin/bash

# Install dependencies
echo "Installing required packages..."
apt-get update
apt-get install -y build-essential python3-pip python3-venv nginx

# Install the Sorbbet program
echo "Installing Sorbbet..."
gcc -o /usr/local/bin/sorbbet src/sorbbet.c
chmod +x /usr/local/bin/sorbbet

# Set up Flask environment
echo "Setting up Flask environment..."
python3 -m venv /opt/flask_env
source /opt/flask_env/bin/activate
pip install -r flask_app/requirements.txt

# Deploy Flask application
echo "Deploying Flask application..."
mkdir -p /opt/flask_app
cp -r flask_app/* /opt/flask_app/
cd /opt/flask_app
pip install -r requirements.txt

# Configure Gunicorn
echo "Configuring Gunicorn..."
cat > /etc/systemd/system/flask_app.service <<EOL
[Unit]
Description=Flask WebGUI for Sorbbet
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/opt/flask_app
ExecStart=/opt/flask_env/bin/gunicorn -b 0.0.0.0:8000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Configure Nginx
echo "Configuring Nginx..."
cat > /etc/nginx/sites-available/flask_app <<EOL
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL

ln -s /etc/nginx/sites-available/flask_app /etc/nginx/sites-enabled/

# Enable and start services
echo "Enabling and starting services..."
systemctl start flask_app
systemctl enable flask_app
systemctl restart nginx

echo "Installation complete!"
