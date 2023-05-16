FROM alpine:latest

# Install dependencies
RUN apk add --no-cache wget

# Download and install Cloud SQL Auth Proxy
RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
RUN chmod +x cloud_sql_proxy

# Copy the service account credentials file to the container
COPY nimble-unison-386200-0ecea84cd92d.json /secrets/cloudsql/nimble-unison-386200-0ecea84cd92d.json

# Start the Cloud SQL Auth Proxy
CMD ["./cloud_sql_proxy", "-instances=main-primary=tcp:5432", "-credential_file=/secrets/cloudsql/nimble-unison-386200-0ecea84cd92d.json"]