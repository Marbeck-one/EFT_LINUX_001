#!/bin/bash

# Módulo 3: Estrategia de Respaldo [cite: 66]

echo "--- Iniciando Respaldo ---"

# Variables de tiempo y nombres [cite: 69]
TIMESTAMP=$(date +"%Y-%m-%d_%H%M")
BACKUP_NAME="backup_web_${TIMESTAMP}.tar.gz"
SOURCE_DIR="/opt/webapp/html"
LOCAL_DEST="/var/backups/webapp"
# IP ficticia o localhost para cumplir requisito académico [cite: 73]
REMOTE_USER="sysadmin"
REMOTE_HOST="127.0.0.1" 
REMOTE_DEST="/tmp/"

# 1. Empaquetado y Compresión [cite: 68]
echo "[+] Generando archivo comprimido $BACKUP_NAME..."
# Crear directorio local si no existe
sudo mkdir -p "$LOCAL_DEST"
# Crear tar.gz
sudo tar -czf "/tmp/$BACKUP_NAME" -C "$SOURCE_DIR" .

# 2. Sincronización Local (Rsync) [cite: 71]
echo "[+] Sincronizando a respaldo local..."
sudo rsync -av "/tmp/$BACKUP_NAME" "$LOCAL_DEST/"

# 3. Transferencia Segura (SCP) [cite: 72]
echo "[+] Transfiriendo a host remoto ($REMOTE_HOST)..."
# Nota: Esto pedirá password si no hay llaves SSH configuradas.
# Para el script no interactivo, idealmente se usan llaves, pero el PDF acepta la sintaxis correcta.
scp "/tmp/$BACKUP_NAME" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DEST}"

# Verificar código de salida [cite: 73]
if [ $? -eq 0 ]; then
    echo "Transferencia exitosa."
else
    echo "Error en transferencia SCP (Posible falta de llaves SSH o conexión)."
fi

# Limpieza temporal
rm "/tmp/$BACKUP_NAME"

echo "--- Respaldo Finalizado ---"
