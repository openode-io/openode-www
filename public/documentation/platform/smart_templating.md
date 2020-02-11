
# Automatic Build Templating

By default, when you run *openode deploy*, it will look for your project structure and find
the most appropriate build template (Dockerfile) for your project, and then deploy.
A build template (Dockerfile) provides the instructions to build your instance
image, which is used to boot up your website. You can also get the auto template
manually via:

    openode template

To get the list of available templates:

    openode list-templates

If you want to use a specific template (non automatic), you can run:

    openode template <template ID>

Templates are fully open sources and available [here](https://github.com/openode-io/build-templates/tree/master/v1/templates/) - open to pull requests!