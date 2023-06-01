# Imagem base
FROM mysql:latest

# Variáveis de ambiente
ENV MYSQL_ROOT_PASSWORD=12345
ENV MYSQL_DATABASE=database
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=12345

# Copiar arquivo SQL para o container#
# COPY script.sql /docker-entrypoint-initdb.d/

# Expor porta padrão do MySQL
EXPOSE 3306