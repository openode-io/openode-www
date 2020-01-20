# Skipping Port Listening Verification (For bots, debugging, tasks)

By default, we require any instance to listen to port 80 when you deploy. If it's not listening, it will fail the deployment.

You can disable this verification, for example if you have a bot with no HTTP server.
Just turn on the following flag and our system will skip this verification:

    openode set-config SKIP_PORT_CHECK true

Then when you redeploy it will not check that your server listens to port 80.