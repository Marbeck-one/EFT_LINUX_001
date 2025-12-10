#!/bin/bash

# Módulo 2: Endurecimiento del Sistema

echo "--- Iniciando Hardening ---"

# 1. Seguridad de Red (UFW)
echo "[+] Configurando Firewall UFW..."
sudo ufw default deny incoming
sudo ufw allow 22/tcp
sudo ufw allow 8080/tcp
echo "y" | sudo ufw enable

# 2. Seguridad del Demonio SSH
echo "[+] Asegurando SSH..."
# Hacemos backup primero
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
# Forzar PermitRootLogin no
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# CORRECCIÓN 1: El servicio se llama 'ssh' en Kali/Debian
sudo systemctl restart ssh

# 3. Permisos de Sistema de Archivos
echo "[+] Aplicando principio de Menor Privilegio..."

# CORRECCIÓN 2: Apuntamos a la ruta real donde está corriendo la app (/opt/webapp)
if [ -f "/opt/webapp/docker-compose.yml" ]; then
    sudo chmod 700 /opt/webapp/docker-compose.yml
    echo "Permisos restringidos aplicados a docker-compose.yml"
else
    echo "AVISO: No se encontró /opt/webapp/docker-compose.yml"
fi

# Permisos para los scripts de mantenimiento y seguridad (ruta relativa)
chmod 700 ../maintenance/backup.sh 2>/dev/null
chmod 700 ../security/hardening.sh 2>/dev/null

echo "--- Hardening Completo ---"
