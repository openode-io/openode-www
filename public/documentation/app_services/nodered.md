# Node-RED

Node-RED is a programming tool for combining together APIs, devices, and online services in interesting and new ways. 

We provide services to deploy quickly Node-RED applications.

# Pricing

A minimum of 100 MB RAM is required, see [our on demand pricing page](/on-demand-pricing). You can also use our [subscription plan](/pricing) which ensure to provide enough memory for your application.

# How to Deploy

There are two ways to deploy Node-RED

## One-Click App

The easiest way to deploy Node-RED is to login in the adminitration panel, then:

- Create an instance with a site name.
- Click Access/Deploy.
- Then click on One-Click App.
- Select nodered.
- Then hit initialize and deploy.

## Using the CLI

If you need more custom configurations and provide a settings.js file, make sure to
install our [CLI](/docs/platform/cli.md), then use the following Dockerfile:

```
FROM nodered/node-red

ENV PORT=80

USER root

COPY settings.js /config/settings.js
```

The last line with *COPY settings.js* is only required if you want to use your own settings.js configurations file. If you want to copy the settings.js file, make sure to run the following command when your instance is deployed:

        openode exec "cp /config/settings.js /data/settings"
        openode deploy


Also make sure to allocate a storage area */data* for persistent storage. 