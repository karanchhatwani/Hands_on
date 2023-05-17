# Use a Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Install Apache and required modules
RUN apt-get update && \
    apt-get install -y apache2 apache2-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable CGI module in Apache
RUN a2enmod cgi && \
    sed -i '/ScriptAlias \/cgi-bin/ s/^#//' /etc/apache2/conf-available/serve-cgi-bin.conf && \
    a2enconf serve-cgi-bin 

COPY credentials.json /app/credentials.json
ENV GOOGLE_APPLICATION_CREDENTIALS=/app/credentials.json
# Install the necessary Python module
RUN pip install pymysql

# Download the Cloud SQL Auth Proxy binary
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy && \
    chmod +x cloud_sql_proxy

# Copy the Python CGI code file to the container
COPY login.py /usr/lib/cgi-bin/login.py
RUN chmod +x /usr/lib/cgi-bin/login.py
# Copy the login page HTML file to the Apache document root
COPY login.html /var/www/html/login.html
RUN service apache2 restart
# Change permissions of the login.py file to make it executable

# Expose port 80 for web access
EXPOSE 80 3306

# Start the Cloud SQL Auth Proxy and Apache service
CMD ./cloud_sql_proxy -instances=nimble-unison-386200:us-central1:main=tcp:3306 & apachectl -D FOREGROUND
