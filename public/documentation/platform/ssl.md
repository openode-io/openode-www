# HTTPS, SSL

# Custom Domains

You can either provide your own certificate or use an external service with automatic SSL support.

## Providing your own certificate

You must provide valid certificate file paths if you need HTTPS. The certificate and private key files must be passed to our servers. Make sure to place the certificate and private key files in a folder (e.g.: certs/), then upload them with:

    openode sync

You must then set the certificate path:

    openode set-config SSL_CERTIFICATE_PATH <your-cert-folder/certfile.crt>

and private key certificate path:

    openode set-config SSL_CERTIFICATE_KEY_PATH <your-cert-folder/keyfile.key>

## Automatic SSL

We do not provide automatic SSL certificates. However you can use an external HTTPS proxy service for automatic SSL, for example using [Cloudflare Free HTTPS](https://www.cloudflare.com/ssl/).

**Note that it is recommended to use Full SSL mode** with Cloudflare. 

- *Full SSL*: By default, we generate a self-signed certificate. And in this case, encryption will be done between the end-user to Cloudflare through opeNode.

# Subdomains (yoursite.openode.dev)

We currently provide HTTPS automatically for \*.openode.dev. That means if you are using
a subdomain instance you are getting automatically HTTPS.

# Force Redirect HTTP to HTTPS

By default, if a valid SSL certificate is available, HTTP traffic is redirected to HTTPS.
This default configuration can be disabled/enabled using the following config - to disable:

    openode set-config REDIR_HTTP_TO_HTTPS false

