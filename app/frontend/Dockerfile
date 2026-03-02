
# On part d'une base Nginx très légère (Alpine Linux)
FROM  nginx:alpine

# On supprime la page par défaut de Nginx
RUN rm -rf /usr/share/nginx/html/*

# On copie notre belle page web dans le dossier que Nginx utilise pour servir les sites
COPY index.html /usr/share/nginx/html/


# On expose le port 80
EXPOSE 80


# La commande de démarrage automatique du conteneur
CMD ["nginx", "-g", "daemon off;"]