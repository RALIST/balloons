web: bundle exec puma -p $PORT -e $RAILS_ENV
release: bundle exec rake db:migrate
worker: bundle exec sidekiq