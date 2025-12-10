#!/bin/bash

# Módulo 1: Aprovisionamiento de Infraestructura [cite: 44]

echo "--- Iniciando Aprovisionamiento ---"

# 1. Gestión de Paquetería: Actualizar e instalar herramientas [cite: 46]
echo "[+] Actualizando repositorios e instalando dependencias..."
sudo apt-get update -y
sudo apt-get install -y git curl ufw docker.io docker-compose

# 2. Estructura de Directorios: Crear ruta de forma idempotente [cite: 47]
echo "[+] Creando directorios de la aplicación..."
if [ ! -d "/opt/webapp/html" ]; then
    sudo mkdir -p /opt/webapp/html
    echo "Directorio /opt/webapp/html creado."
else
    echo "El directorio ya existe."
fi

# 3. Obtención de Recursos: Descargar docker-compose.yml [cite: 48, 49]
echo "[+] Descargando docker-compose.yml..."
# URL proporcionada en el PDF
URL="https://gist.githubusercontent.com/DarkestAbed/0clcee748bb9e3b22f89efe1933bf125/raw/5801164c0a6e4df7d8ced00122c76895997127a2/docker-compose.yml"
# Nota: El PDF tiene un espacio en 'Darkest Abed', verifica si la URL real lleva espacio o no. Asumiré sin espacio o %20.
# Descargamos en el directorio actual (deploy/) o lo movemos donde se ejecutará.
# El PDF dice "en la ruta de trabajo"[cite: 48].
sudo curl -o ./docker-compose.yml "$URL"

# 4. Generación de Contenido: index.html personalizado [cite: 50, 51]
echo "[+] Generando index.html..."
# Reemplaza 'TU_NOMBRE' con tu nombre real
CONTENT="<h1>Servidor Seguro Propiedad de [TU_NOMBRE - Acceso Restringido]</h1>"
echo "$CONTENT" | sudo tee /opt/webapp/html/index.html > /dev/null

# 5. Gestión de Identidad: Usuario sysadmin [cite: 52]
echo "[+] Configurando usuario sysadmin..."
if id "sysadmin" &>/dev/null; then
    echo "El usuario sysadmin ya existe."
else
    sudo useradd -m -s /bin/bash sysadmin
    sudo usermod -aG docker sysadmin
    echo "Usuario sysadmin creado y agregado al grupo docker."
fi

# Iniciar servicios Docker (por si acaso no arrancaron)
sudo systemctl enable docker
sudo systemctl start docker

# Desplegar el contenedor (opcional aquí, o manual después)
# sudo docker-compose up -d
echo "--- Aprovisionamiento Completo ---"
