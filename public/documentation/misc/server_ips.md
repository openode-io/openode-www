# List of server IPs

If you need for example to whitelist the remote IPs which can access a certain external resource (e.g., a database), you can whitelist our IPs based on the location.
First you need to get the location *str_id*, which is available here:

    https://api.openode.io/global/available-locations

Using the proper *str_id* depending where you deployed, you can get the list of IPs here

    https://api.openode.io/global/available-locations/global/available-locations/:str_id/ips

