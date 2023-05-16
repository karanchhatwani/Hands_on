#!/bin/bash

# Start the Cloud SQL Auth Proxy
./cloud_sql_proxy -instances=main-primary=tcp:5432 &

# Start your application
# Replace the command below with the actual command to start your application
# For example:
# exec java -jar your-application.jar

# Keep the container running
exec tail -f /dev/null
