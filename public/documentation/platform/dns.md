
# Domain Name System (DNS) for Custom Domains

The DNS settings are available either while using the *CLI at the end of a deployment* or via the *administration*, under Settings > DNS and Aliases.

We provide both CNAME and A records to use, see below the details.

## CNAME Record (Recommended)

Depending on the location, you will get a CNAME record accordingly.
CNAME records are recommended, since they are not set to specific IPs and
will thus not change over time. If we change the servers configurations or infratructure,
you will not be impacted.

*Important note*: If you need to set a *root domain* (Example: mydomain.com), you can use an ALIAS @ or URL redirect to redirect to a subdomain such as www.mydomain.com, and where www.mydomain.com itself can be a CNAME record.

## A Record (Can change over time, not recommended)

We also provide an A Record in case you want to test it with an A Record.
However, it is worth noting that the provided IP *can* change over time, and so
it is not recommended.

### ---

## Alias a custom domain to an opeNode subdomain

It is not currently possible to add a custom domain (myexample.com) alias to a subdomain (myexample.openode.io).

You can however set an **Host** header, as follows with curl:

    curl -H "Host: myexample.openode.io" https://myexample.com/

