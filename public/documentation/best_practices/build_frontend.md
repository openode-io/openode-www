# Building and publishing a frontend application (Vue.js, React, Angular, etc.)

This guide is for users who want to build and deploy a frontend application such as Vue.js, React, etc.

## .openodeignore the build folder

The folder where the frontend files are built should not be sent. You can do so by creating a **.openodeignore** file with the folder name, for example for Vue.js:

    dist/

Further, your **.gitignore** should include .openode which contains the openode credentials:

    .openode

## Building the frontend application via the Dockerfile

In the following example, we will create a Dockerfile to build a Vue.js application. 
It includes [http-server](https://www.npmjs.com/package/http-server) which is a convenient way to serve the frontend files, by simply specifying the folder containing the frontend files.

    FROM node:12-alpine

    WORKDIR /opt/app

    ENV PORT=80

    RUN npm install -g http-server

    # Install app dependencies
    # A wildcard is used to ensure both package.json AND package-lock.json are copied
    # where available (npm@5+)

    COPY package*.json ./

    RUN npm install

    # Bundle app source
    COPY . .

    RUN npm run build

    CMD [ "http-server", "dist" ]

We made a [sample project](https://github.com/openode-io/vuejs-hello-world) using this Dockerfile and Vue.js.