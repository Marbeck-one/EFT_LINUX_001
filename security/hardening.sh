#!/bin/bash

# Módulo 2: Endurecimiento del Sistema [cite: 53]

echo "--- Iniciando Hardening ---"

# 1. Seguridad de Red (UFW) [cite: 58-61]
echo "[+] Configurando Firewall UFW..."
# Política por defecto: Denegar todo el tráfico entrante
sudo ufw default deny incoming
# Permitir SSH (Puerto 22)
sudo ufw allow 22/tcp
# Permitir Aplicación Web (Puerto 8080)
sudo ufw allow 8080/tcp
# Habilitar el firewall (sin confirmación interactiva)
echo "y" | sudo ufw enable

# 2. Seguridad del Demonio SSH [cite: 62, 63]
echo "[+] Asegurando SSH..."
# Usamos sed para reemplazar 'PermitRootLogin yes' o comentado, por 'no'
# Hacemos backup primero por seguridad
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
# La expresión regular busca PermitRootLogin y lo fuerza a 'no'
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
# Reiniciamos servicio ssh para aplicar cambios
sudo systemctl restart sshd

# 3. Permisos de Sistema de Archivos [cite: 64, 65]
echo "[+] Aplicando principio de Menor Privilegio..."
# Asumimos que los scripts están en el directorio actual o ajustamos la ruta
chmod 700 ../deploy/docker-compose.yml 2>/dev/null || echo "Aviso: docker-compose.yml no encontrado en ruta relativa."
chmod 700 ../maintenance/backup.sh 2>/dev/null
chmod 700 ../security/hardening.sh 2>/dev/null

echo "--- Hardening Completo ---"
