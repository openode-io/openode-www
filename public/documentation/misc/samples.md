Find below some examples/samples in order to get your first opeNode website online.

# Node.js Hello World

This example is a simple express.js-based server displaying a page with traditional Hello World.

First git clone the project:

    git clone https://github.com/openode-io/openode-hello-world.git

Then go to the directory:

    cd openode-hello-world

Then deploy it on opeNode:

    openode deploy

If you don't yet have openode installed, refer to the [CLI installation page](/docs/installation/index.md).

# Chat example using socket.io

This example uses socket.io for real-time messaging between multiple online chat users.

git clone the project:

    git clone https://github.com/openode-io/openode-chat-example.git

cd in the folder

    cd openode-chat-example

Then deploy it on opeNode:

    openode deploy

# MMO game using Node.js, phaser.io, and socket.io

This MMO game example uses socket.io, Phaser, and Node.js. Phaser is a widely used HTML5 framework for games.

git clone the project:

    git clone https://github.com/openode-io/openode-basic-mmo-phaser.git

cd in the folder

    cd openode-basic-mmo-phaser

Then deploy it on opeNode:

    openode deploy

# Continuous Integration with bitbucket pipelines

This sample demonstrates how to integrate with bitbucket pipelines.

git clone the project:

    git clone https://github.com/openode-io/openode-bitbucket-pipelines.git

cd in the folder

    cd openode-bitbucket-pipelines

Then if you commit it on bitbucket it will get deployed automatically.

Note that you need to set $OPENODE_TOKEN and $OPENODE_SITENAME in your bitbucket environment variables.