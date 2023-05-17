FROM alpine:latest

RUN apk update && apk add apache2

COPY index.html /var/www/html/

EXPOSE 80

CMD ["httpd", "-D", "FOREGROUND"]
