# Continuous Integration / Continuous Delivery

If you need to integrate opeNode in your CI/CD tooling for deploying, you can do so using the API/CLI Token available in Administration > Account and your site name.

## Github Action

Github action allows to deploy your site on git pushes using our CLI. Just copy the following content to a file .github/workflows/openode.yml:

    name: opeNode

    on:
      push:
        branches:
          - master

    jobs:
      deploy-on-openode:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          -
            name: deploy
            run: |
              export OPENODE_TOKEN="${{ secrets.OPENODE_TOKEN }}"
              export OPENODE_SITE_NAME="${{ secrets.OPENODE_SITE_NAME }}"
              sudo npm i -g openode
              openode ci-conf $OPENODE_TOKEN $OPENODE_SITE_NAME
              openode deploy

The secrets OPENODE\_TOKEN and OPENODE\_SITE\_NAME should be created in your github settings secrets, see [the github documentation](https://docs.github.com/en/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository).

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
