RAKE = docker-compose run app bundle exec rake
RUN = docker-compose run app

install:
	@make secert
	@touch app.local.env
	@docker-compose build
	@$(RUN) bundle install --retry=3 --jobs=2
	@$(RUN) bundle exec rails db:create
	@$(RUN) bundle exec rails db:migrate
	@$(RUN) bundle exec rails db:seed
	@$(RUN) bundle exec rails assets:precompile RAILS_ENV=production
	@make reindex
update:
	@make secert
	@touch app.local.env
	@docker-compose build
	@$(RUN) bundle install --retry=3 --jobs=2
	@$(RUN) bundle exec rails db:migrate
	@$(RUN) bundle exec rails assets:precompile RAILS_ENV=production
	@make stop && make start
restart:
	@make stop && make start
start:
	@docker-compose up -d
status:
	@docker-compose ps
stop:
	@docker-compose stop web app worker
stop-all:
	@docker-compose down
console:
	@$(RUN) bundle exec rails console
reindex:
	@echo "Reindex ElasticSearch..."
	@$(RAKE) environment elasticsearch:import:model CLASS=Topic FORCE=y
	@$(RAKE) environment elasticsearch:import:model CLASS=Page FORCE=y
	@$(RAKE) environment elasticsearch:import:model CLASS=User FORCE=y
secert:
	@test -f app.secret.env || echo "secret_key_base=`openssl rand -hex 32`" > app.secret.env
start-brew-services:
	@brew services start memcached
	@brew services start postgres
	@brew services start redis
	@brew services start elasticsearch
	@brew services start nginx
stop-brew-services:
	@brew services stop memcached
	@brew services stop postgres
	@brew services stop redis
	@brew services stop elasticsearch
	@brew services stop nginx