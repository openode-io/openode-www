# Monitoring your website healthiness using a status check

For a variety of reasons, you application can become unavailable, for instance if:

* Your instance is running out of memory.
* Your instance crashed and is unable to reboot itself.
* Etc.

You can use an external status checker service, such as [UptimeRobot](https://uptimerobot.com/), in order to periodically verify that your site is still up and running, and whenever it goes unavailable, you get notified.