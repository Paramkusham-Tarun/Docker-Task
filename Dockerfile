# Use an official Alpine Linux runtime as a parent image
FROM alpine:latest

# Install dependencies
RUN apk --no-cache add curl jq python3 bash

# Set the working directory
WORKDIR /usr/src/app

# Copy the shell script into the container
COPY entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# Copy the cron job file into the cron.d directory
COPY cronjob /etc/cron.d/generate_report_cron
RUN chmod 0644 /etc/cron.d/generate_report_cron

# Apply cron job
RUN crontab /etc/cron.d/generate_report_cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Expose port 8080
EXPOSE 8080

# Run the command on container startup
CMD ["sh", "-c", "crond -f & tail -f /var/log/cron.log"]

