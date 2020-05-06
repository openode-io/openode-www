# Testing your application locally

If you are having trouble to get it up and running with for example *openode deploy*, you can test it on your local machine for further debugging.


## Installation

You will need docker to build your instance, see the following link to get it:

- [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)

## Building the image

You need to make sure that you have a *Dockerfile*. Please see this [doc](/docs/platform/smart_templating.md) if you do not already have one.

Once you have docker and your Dockerfile, you are good to go and build it via:

    docker build . -t my-app

This is building an image tagged *my-app* which can be used to run your application.

## Run

Using your build image (my-app) you can now run it via:

    docker run -d -p 8080:80 my-app

Then you can access your site at: http://localhost:8080/.

You can also look at the logs of your application with:

    docker ps | grep my-app

And using the container ID:

    docker logs -f <container ID>