# Environment Variables

For convenience, we provide several ways to set your environment variables. Environment variables
are useful to pass parameter to your deployed application. For instance, if you are using
an external database, you will probably need its hostname, user, password, and database name.
These values can be passed via environment variables and your application will be able
to access them.

## Dotenv (.env)

The dotenv method is used when you provide a .env file in your project root folder.
The format of .env is simple and efficient, here is an exemple .env file:

    variable1=value1
    variable2=value2

This file defines 2 variables (variable1, variable2) associated to specific values.

If your application is Node.js based, you will be able to access environment variables
via [process.env](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env)
and you will be able to retrieve *variable1, variable2* via *process.env.variable1 and
process.env.variable2*. Pretty much all programming language allows to access environment
variables in a convenient manner.

### Custom dotenv filepath

If you want to use a dotenv which is different than **.env**, you can specify a filepath:

    openode set-config DOTENV_FILEPATH <path>

Example **path** can be for example **.production.env** for a specific production environment file.

## CLI

The CLI can be used to set environment variables. To create or update a variable:

    openode set-env <variable> <value>

To remove an existing variable:

    openode del-env <variable>

You can also viewed the stored environment variables with:

    openode env

*Note that the stored variables override the variables in .env files.*

## Dockerfile ENV

Your Dockerfile can contain ENV commands allowing to set environment variables. To use this method, just add ENV commands in your Dockerfile, for example:

    ENV variable1=value1
    ENV variable2=value1

In general it's best to put non sensitive variables using this method, as typically Dockerfile
files are commited to a source control tool (for example git), as opposed to .env which are
normally not commited/published.

[More information on ENV in Dockerfile](https://docs.docker.com/engine/reference/builder/#env).

