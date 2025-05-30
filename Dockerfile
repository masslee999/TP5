# Utilise l’image officielle d’Apache
FROM httpd:latest

# Copie les fichiers dans le répertoire par défaut d’Apache
COPY . /usr/local/apache2/htdocs/

# Déclare le port 80 (celui utilisé par le serveur web Apache)
EXPOSE 80