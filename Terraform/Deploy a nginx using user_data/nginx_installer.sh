#!/bin/bash
sudo dnf update -y # dnf = Dandified YUM administrador de paquetes en fedora
sudo dnf install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
