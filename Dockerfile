FROM alpine:latest
RUN  yum install httpd -y
COPY ./public-html/ /var/www/html/
CMD ["httpd-foreground"]
