# Known Limitations

This document lists known limitations of our platform.

## Unable to request from one website to any other website within the same location.

Due to an known [issue](https://github.com/kubernetes/kubernetes/issues/66607) with one product we are using (Kubernetes), it's not currently possible to request to your own website, or any other website in the same location using the hostname, from within your given instance. If accessed externally (e.g.: from the HTML) there is no issue as the request will be routed to the proper instance.

*Workarounds:*

- Use two different locations. Requesting to the second location of two hosted sites works seemlessly.
- Use the private IP over HTTP to communicate to the destination instance, see [Environment Variables, MAIN\_SERVICE\_SERVICE\_HOST](/docs/platform/env_vars.md).