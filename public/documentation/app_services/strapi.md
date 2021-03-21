# Strapi

![alt text](/images/logo/strapi.svg)

Strapi is the leading open-source headless CMS. It’s 100% Javascript, fully customizable and developer-first.



## Setup

Make sure to follow the strapi CLI documentation, [https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/installation/cli.html](https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/installation/cli.html)

For example:

        npx create-strapi-app my-project --quickstart

Then go to the generated project:

        cd my-project

Then add the proper Dockerfile:

        openode template node-minimal

And make sure to increase the maximum build duration, such as:

        openode set-config MAX_BUILD_DURATION 150


## Deploy

To deploy, just hit:

        openode deploy