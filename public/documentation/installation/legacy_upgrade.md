# Upgrade

## Deprecation dates

If you created an instance before December 2021, please note the dates below.

* **December 1 2021**: Open source instances must migrate to v3.
* **March 1 2022**: All instances must be migrated to v3.

## Deprecation of \<subdomain\>.openode.io and \<subdomain\>.eu.openode.io

Subdomains URLs \<subdomain\>.openode.io and \<subdomain\>.eu.openode.io will be deprecated in favor of \<subdomain\>.openode.dev.

## Deprecation notices

Please note the following breaking changes:

- Addons. Addons will no more be supported.
- Persistence. Users are recommended to use external storage services, such as a Database, remote file systems, etc. If you need to replace sqlite, note that most of your SQL queries will work if you use a database such as PostgreSQL, MySQL, etc. [PostgreSQL provider with a free plan](https://www.elephantsql.com/plans.html).
- `SKIP_PORT_CHECK` configuration. Instances must be listening to the HTTP port specified by the environment variable *PORT*, defaulted to port 80.
- .env file: Environment variables can not more be set using .env file. [See the environment variables documentation](https://www.openode.io/docs/platform/env_vars.md).

## Notes for websites using web socket

To use web sockets, you will need to change the following configuration:

- **Change the execution layer to kubernetes.** To do it, run the following command: `openode set-config EXECUTION_LAYER kubernetes`.


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

#### DNS update (custom domains)

Also make sure to update to the new DNS settings provided by the CLI or the administration dashboard:

- CNAME for us-central-1: `us_central_1.openode.io`
- CNAME for eu-west-1: `eu_west_1.openode.io`