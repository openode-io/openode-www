# Upgrade

The only required piece to be regularly upgraded is our CLI.

## Deprecation dates (instances deployed before March 15 2020)

If you created an instance before March 15, please note the dates below.

* **April 15 2020**: Instances deployed in **Canada** will need to be upgraded.
* **April 10 2020**: Instances deployed in **France** will need to be upgraded.
* **March 31 2020**: Instances deployed in **USA** will need to be upgraded.

## Deprecation of \<subdomain\>.us.openode.io and \<subdomain\>.fr.openode.io

On March 31, and April 10, respectively, subdomains URLs \<subdomain\>.us.openode.io and \<subdomain\>.fr.openode.io will be deprecated in favor of \<subdomain\>.openode.io.

## Deprecation of DNS nameservers (ns1.vultr.com, ns2.vultr.com)

When you use the new system, the nameservers ns1/2.vultr.com are no more updated.

You have to use the DNS settings provided at the end of the deployment or in the administration > Instances > Settings > DNS and Aliases.

## Upgrading

**Important note:**

* When you have upgraded, deployed subdomains until **April 15 2020** will
get http://subdomain.dev.openode.io/ addresses **without HTTPS**. From **April 15 2020**, deployed subdomains will get https://subdomain.openode.io/ addresses **with HTTPS**.
* Custom domains are not impacted, and so you can deploy right now custom domains and use your SSL certificate.

### 1- Upgrade your CLI

The CLI, which is a regular NPM package, can be upgraded with:

    npm i -g openode

Note that you can skip the following steps if you just destroy your instance, remove Dockerfile, and recreate a new one.

### 2- Stop and Remove the current location

The following steps should be done:

#### 2.1- Make sure to first stop your instance

    openode stop

#### 2.2- Delete the current location

    openode del-location <current location>

If you don't know the location you can use:

    openode locations

#### 2.3- Add the USA location

    openode add-location usa

### 3- Legacy to v1

On March 2020 we made a new major version of our deployment system. Therefore, if you
had instances before March 2020, you have to upgrade them as follows.

**First** you have to set the following configuration:

    openode set-config TYPE kubernetes

**Next,** make sure to back up your Dockerfile:

    mv Dockerfile Dockerfile.bak

Then apply the new template (this will generate a Dockerfile):

    openode template


If you want to manually upgrade your Dockerfile, the only difference is that you need to 
copy the files in the images, and also packages can be installed directly. 
If we take the new Node.js template:

    FROM node:12-alpine

    WORKDIR /opt/app

    # daemon for cron jobs
    RUN echo 'crond' > /boot.sh
    # RUN echo 'crontab .openode.cron' >> /boot.sh

    # Install app dependencies
    # A wildcard is used to ensure both package.json AND package-lock.json are copied
    # where available (npm@5+)

    COPY package*.json ./         # *** Copy the package.json in the image

    RUN npm install --production  # *** Install packages in the image

    # Bundle app source
    COPY . .                      # *** Copy all files in the image

    EXPOSE 80
    CMD sh /boot.sh && npm start

