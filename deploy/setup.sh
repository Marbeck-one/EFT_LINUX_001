#!/bin/bash

# Módulo 1: Aprovisionamiento de Infraestructura [cite: 44]

echo "--- Iniciando Aprovisionamiento ---"

# 1. Gestión de Paquetería [cite: 46]
echo "[+] Actualizando e instalando dependencias..."
sudo apt-get update -y
sudo apt-get install -y git curl ufw docker.io docker-compose

# 2. Estructura de Directorios [cite: 47]
echo "[+] Creando directorios de la aplicación..."
# Creamos la ruta completa para asegurar que exista
sudo mkdir -p /opt/webapp/html

# 3. Obtención de Recursos (CORREGIDO) [cite: 48]
# Generamos el archivo DIRECTAMENTE en la ruta destino para evitar errores de URL o 404
echo "[+] Generando docker-compose.yml en /opt/webapp/..."
sudo bash -c 'cat > /opt/webapp/docker-compose.yml <<EOF
version: "3.8"
services:
  web_app:
    image: nginx:alpine
    container_name: production_web
    restart: always
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
    environment:
      - NGINX_HOST=localhost
      - NGINX_PORT=80
EOF'

# 4. Generación de Contenido [cite: 50, 51]
echo "[+] Generando index.html..."
# Usamos tu nombre real como pide el requisito
CONTENT="<h1>Servidor Seguro Propiedad de [RODRIGO_MARTINEZ - Acceso Restringido]</h1>"
echo "$CONTENT" | sudo tee /opt/webapp/html/index.html > /dev/null

# 5. Gestión de Identidad [cite: 52]
echo "[+] Configurando usuario sysadmin..."
if id "sysadmin" &>/dev/null; then
    echo "El usuario sysadmin ya existe."
else
    sudo useradd -m -s /bin/bash sysadmin
    sudo usermod -aG docker sysadmin
fi

# Asegurar servicios
sudo systemctl enable docker
sudo systemctl start docker

echo "--- Aprovisionamiento Completo ---"
echo "Para desplegar, ejecuta: cd /opt/webapp && sudo docker-compose up -d"
