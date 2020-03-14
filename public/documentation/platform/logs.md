# Logs

Logs can be accessed either from the CLI or via the administration panel, as described below.
To create logs, you can simply output to stdout/stderr from your application. Then your logs
are available as described below.
For example, in Node.js, 

    console.log("My log here...")

Outputs to stdout and will be available.

## Administration

Logs are not yet available via the administration. It will be added as soon as possible.

## CLI

To get the latest logs on the stdout/stderr, you can use the following command:

    openode logs

This command however limits and only show the latest logs. For further logs, run:

    openode logs -n <nb lines>