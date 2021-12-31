
# Web socket

Web sockets are supported, but as we are serverless by default, you should change the execution layer to make it work well with web sockets, as web socket connections are kept alive on the server:

    openode set-config EXECUTION_LAYER kubernetes

