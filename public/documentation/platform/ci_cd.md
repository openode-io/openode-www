# Continuous Integration / Continuous Delivery

If you need to integrate opeNode in your CI/CD tooling for deploying, you can do so using the API/CLI Token available in Administration > Account and your site name.

## With Travis CI

Find below a sample (.travis.yml)

    language: node_js

    before_script:
    - npm i -g openode

    script:
      - env bash scripts/deploy.sh

Where scripts/deploy.sh corresponds to:

    openode ci-conf $OPENODE_TOKEN $OPENODE_SITE_NAME
    openode deploy

Where $OPENODE\_TOKEN and $OPENODE\_SITE\_NAME are environment variables which need to be set.

## With other CI/CD tools

Similarly with other tools, you can deploy with:

    npm i -g openode
    openode ci-conf $OPENODE_TOKEN $OPENODE_SITE_NAME
    openode deploy

And ensure to have environment variables $OPENODE\_TOKEN $OPENODE\_SITE\_NAME configured.
