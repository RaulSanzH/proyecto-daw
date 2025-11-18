# Imagen base oficial de Apache
FROM httpd:2.4

# Instalar OpenSSL para certificados
RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

# Crear carpeta para certificados
RUN mkdir /usr/local/apache2/conf/ssl

# Generar certificado auto-firmado
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /usr/local/apache2/conf/ssl/server.key \
    -out /usr/local/apache2/conf/ssl/server.crt \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=DAW/OU=Dept/CN=localhost"

# Copiar html
COPY html/ /usr/local/apache2/htdocs/

# Copiar configuración SSL
COPY ssl.conf /usr/local/apache2/conf/extra/ssl.conf

# Habilitar módulo SSL
RUN sed -i '/#LoadModule ssl_module/ s/^#//' /usr/local/apache2/conf/httpd.conf

# Establecer ServerName para evitar advertencias
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf
# Incluir ssl.conf
RUN echo "Include conf/extra/ssl.conf" >> /usr/local/apache2/conf/httpd.conf

# Exponer puertos
EXPOSE 80 443
