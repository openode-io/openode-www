
# Deploying an Instance

First, just go to your project directory in command line:

    cd [your project directory]

And then just type to deploy using the files in the current directory:

    openode deploy

You can also deploy using a git repository url:

    openode deploy https://yourgitrepository/

For example using a github repository.

Under the hood, *openode deploy* is in fact doing the following commands:

    openode sync
    openode template
    openode restart

## Synchronizing the remote files

If you just need to synchronize your remote repository, just hit the following command:

    openode sync

It will ensure that your local file changes are sent to our remote repository.

### .openodeignore - ignoring certain files/folders

If you add a .openodeignore file in your repository, the list of files provided in this file will get ignored (not sent). The format is to the well known .gitignore. Just use .openodeignore to list your files to ignore. You can of course also have a .gitignore used for git in your repository.

Notice that we do not support wildcards, such as thisfolder/\* or thisfolder/\*\*/\*.txt. Example .openodeignore we support:

    logs/
    passwd.txt
    testfolder/withsub-folder/

## Restarting an Instance

If you just need to deploy your instance with no files synchronization, it can be
done via:

    openode restart

## Fast reload

To simply reload your container, the following command can be used:

    openode reload

Note that it must already be online.

## Skip port check

If you do not need an HTTP server (e.g.: for bots), you can skip the port verification at boot time:

        openode set-config SKIP_PORT_CHECK true

