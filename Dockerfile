FROM alpine:latest
RUN sudo yum install httpd -y
COPY ./public-html/ /var/www/html/
CMD ["httpd-foreground"]
