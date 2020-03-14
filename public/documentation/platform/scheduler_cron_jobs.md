# Scheduler / Cron Jobs

The scheduler functionnality allows to define recurring jobs using the crontab format.
It can be configured either via the administration or via command lines.

A cron job file looks like the following:

    # m h  dom mon dow   command
    0 5 * * * cd /opt/app/ && node job.js

In this example it will run **node job.js** everyday at 5 o'clock.

## Administration

The scheduler is accessible via the Administration, in instance Settings > Scheduler.

Note that by default, .openode.cron is written automatically when you set the scheduler via the administration.

## Update your Dockerfile

In most templates Dockerfile, we include instruction for activating cronjobs.

For example, the Node.js minimal template contains the following lines:

    RUN echo 'crond' >> /boot.sh
    # RUN echo 'crontab .openode.cron' >> /boot.sh
    # ...
    # CMD sh /boot.sh && npm start

And so to activate cronjobs you just need to uncomment the second line, to have:

    RUN echo 'crond' >> /boot.sh
    RUN echo 'crontab .openode.cron' >> /boot.sh
    # ...
    # CMD sh /boot.sh && npm start