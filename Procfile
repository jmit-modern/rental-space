web:bundle exec rails server -p 3000 -b ${HOST:="127.0.0.1"}
worker: bundle exec sidekiq --environment ${RAILS_ENV:="production"} -C config/sidekiq.yml
release: rake db:migrate