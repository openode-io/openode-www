# Cron, scheduled tasks

You can enable cron/recurring jobs by using cron and crontab. This is however something
not officially available, but you can configure yourself.

## Dockerfile

See below an example Dockerfile with a cron job running every minute:

    FROM node:16-alpine

    WORKDIR /opt/app

    ENV PORT=80

    # daemon for cron jobs
    RUN echo 'crond' > /boot.sh # <-----
    RUN echo 'crontab .openode.cron' >> /boot.sh # <-----


    COPY package*.json ./

    RUN npm install --production

    # Bundle app source
    COPY . .

    CMD sh /boot.sh && npm start # <-----

The relevant lines are just below "daemon for cron jobs" and the last line
ensure to active it at boot time.

## .openode.cron file

The crontab format can be used. See below an example cron file:

    * * * * * cd /opt/app ; node cronjob.js >> out.txt