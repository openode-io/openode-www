# Upgrade

## Deprecation dates

If you created an instance before December 2021, please note the dates below.

* **December 1 2021**: Open source instances must migrate to v3.
* **March 1 2022**: All instances must be migrated to v3.

## Deprecation of \<subdomain\>.openode.io and \<subdomain\>.eu.openode.io

Subdomains URLs \<subdomain\>.openode.io and \<subdomain\>.eu.openode.io will be deprecated in favor of \<subdomain\>.openode.dev.

## Deprecation notices

We will stop providing the following services:

- Addons
- Persistence. Users are recommended to use external storage services, such as a Database, remote file systems, etc.

## Notes for web socket websites

As we are moving into a serverless architecture, web socket can still work, but a key-value
caching system (redis, memcached, etc.) or database needs to be used to synchronize properly with connected clients.
We will provide a sample example soon. [https://redis.com/](https://redis.com/) provides a free tier plan which can be used for that purpose.

## Upgrading


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

### 3- Legacy to v3

For upgrading to v3, make sure to read the following instructions.

#### Change version to v3

**First** you have to set the following configuration:

    openode set-config VERSION v3

#### Add a new location

Make sure to add a new location, you can list available locations with:

    openode locations

#### Set a new plan

Make sure to set a new plan, the available plans can be listed via:

    openode plans

And then change be changed with:

    openode set-plan <PLAN ID>

#### Deploy

Then deploy your instance:

    openode deploy