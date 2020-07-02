web: bundle exec thin start -p $PORT
release: bundle exec rake db:migrate
worker: rake db:load