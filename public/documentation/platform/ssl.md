# HTTPS, SSL

# Custom Domains

You must provide valid certificate file paths if you need HTTPS. The certificate and private key files must be passed to our servers. Make sure to place the certificate and private key files in a folder (e.g.: certs/), then upload them with:

    openode sync

You must then set the certificate path:

    openode set-config SSL_CERTIFICATE_PATH <your-cert-folder/certfile.crt>

and private key certificate path:

    openode set-config SSL_CERTIFICATE_KEY_PATH <your-cert-folder/keyfile.key>

# Subdomains

We currently provide HTTPS automatically for \*.openode.io. That means if you are using
a subdomain instance you are getting automatically HTTPS.
