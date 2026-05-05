FROM alpine:latest

# Install tar (Alpine has a stripped-down version by default, this gets the full one)
RUN apk add --no-cache tar tzdata

COPY backup.sh /usr/local/bin/backup.sh

RUN chmod +x /usr/local/bin/backup.sh

# Add the cron job to run at 4:00 AM every day, adjust this to your liking!
# The part in the middle just outputs the cron job into the docker logs

RUN echo "0 4 * * * /usr/local/bin/backup.sh > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/crontabs/root

# Start the cron daemon in the foreground, adjust this too if you want!

CMD ["crond", "-f", "-d", "8"]
