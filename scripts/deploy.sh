set -e

echo $SERVER_PK_KEY | base64 --decode > id_rsa_tmp
chmod 400 id_rsa_tmp

ssh -i id_rsa_tmp -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_HOST \
  "PATH=\"$PATH:$RUBY_BIN_PATH:$NODE_BIN_PATH\" && \
  cd $PROJECT_PATH && \
  echo 'CWD:' && pwd && \
  echo 'git pulling' && git pull && \
  echo 'bundle install' && bundle install && \
  echo 'yarn' && yarn && \
  echo 'rails assets:precompile' && RAILS_ENV=$RAILS_ENV rails assets:precompile && \
  RAILS_ENV=$RAILS_ENV ./bin/rails db:migrate && \
  pm2 restart openode-www && \
  pm2 list"

rm -f id_rsa_tmp
