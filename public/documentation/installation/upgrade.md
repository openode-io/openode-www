# Upgrade

The only required to be regularly upgraded is our CLI.

## Upgrading the CLI

The CLI, which is a regular NPM package, can be upgraded with:

    npm i -g openode

## Legacy to v1

On February 2020 we made a new major version of our deployment system. Therefore, if you
had instances before February 2020, you have to upgrade them as follows.

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