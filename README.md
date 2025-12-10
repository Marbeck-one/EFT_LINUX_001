# Entrega Final Transversal - Infraestructura TechSolutions

## Guía de Despliegue
Instrucciones para desplegar la infraestructura en un entorno limpio:

1. Clonar el repositorio:
   `git clone https://github.com/Marbeck-one/EFT_LINUX_001.git`
2. Ingresar al directorio:
   `cd EFT_LINUX_001`
3. Dar permisos de ejecución:
   `chmod +x deploy/setup.sh security/hardening.sh maintenance/backup.sh`
4. Ejecutar aprovisionamiento:
   `sudo ./deploy/setup.sh`
5. Levantar el servicio web:
   `cd /opt/webapp && sudo docker-compose up -d`
6. Aplicar seguridad:
   `sudo ./security/hardening.sh`

## Justificación de Seguridad
En este proyecto se han aplicado principios de defensa en profundidad para mitigar riesgos comunes:

1. **Bloqueo de Root (SSH):** Se deshabilitó el acceso remoto directo del superusuario (`PermitRootLogin no`). Esto protege contra ataques de fuerza bruta automatizados que apuntan por defecto al usuario 'root'. Obliga a los atacantes a adivinar un nombre de usuario válido primero, aumentando la complejidad del ataque y garantizando la trazabilidad de las acciones administrativas.
2. **Firewall (UFW):** Se configuró una política de "Denegar todo por defecto" (Default Deny Incoming). Solo se permiten los puertos 22 (gestión) y 8080 (servicio web). Esta reducción de la superficie de ataque asegura que, incluso si se levantan servicios vulnerables accidentalmente en otros puertos, estos no sean accesibles desde el exterior.

## Evidencia de Validación

### Acceso Web Exitoso
![Web Access](evidence/web_access.png)

### Estado del Firewall
![UFW Status](evidence/ufw_status.png)

### Configuración SSH Segura
![SSH Config](evidence/ssh_config.png)
