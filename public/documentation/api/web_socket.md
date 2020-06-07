# Web Socket API

To get real-time information about your instances we provide a web socket API which can be used as described below. We describe the usage using the node [ws](https://www.npmjs.com/package/ws) package for illustration - any web socket client can be used.

## Connecting

To connect, you need to specify both our web socket API url and API token, as follows:

    const ws = new WebSocket("wss://api.openode.io/streams", {
      headers: {
        token: "Your token here"
      }
    })

Note that you can also specify the token in the query string (wss://api.openode.io/streams?token=YOUR\_TOKEN).

## Subscribing to a channel

To subscribe to a given channel, you need to send a message as follows:

    const msgToEstablish = {
      command: 'subscribe',
      identifier: JSON.stringify(channelParameters)
    }
    ws.send(JSON.stringify(msgToEstablish))

Where *channelParameters* is:

    {
      channel: "name of the channel",
      otherParameters: "...",
      ...
    }

## Available Channels

### Deployment Channel

    channelParameters = {
      channel: 'DeploymentsChannel',
      deployment_id: "deployment ID"
    }

### WebsiteEvents Channel

    channelParameters = {
      channel: 'WebsiteEventsChannel',
      website_id: "website ID"
    }

## Receiving messages

To read the messages, you can get them as follows:

    ws.on('message', (msg) => {
      // process the msg here...
    })