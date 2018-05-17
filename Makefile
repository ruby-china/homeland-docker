RAKE = docker-compose run app bundle exec rake
RUN = docker-compose run app
RUN_WEB = docker-compose run web
ACME = /root/.acme.sh/acme.sh
ACME_HOME = --home /var/www/ssl

install:
	@make secret
	@touch app.local.env
	@$(RUN) bundle install --retry=3 --jobs=2
	@$(RUN) bundle exec rails db:create
	@$(RUN) bundle exec rails db:migrate
	@$(RUN) bundle exec rails db:seed
	@$(RUN) bundle exec rails assets:precompile RAILS_ENV=production
	@make reindex
install_ssl:
	rm -f etc/nginx/conf.d/homeland/ssl.conf
	docker-compose start web
	$(RUN_WEB) bash -c 'echo $$cert_domain'
	$(RUN_WEB) bash -c '$(ACME) --issue -d $$cert_domain -w /var/www/homeland/public $(ACME_HOME) --debug'
	openssl dhparam -out shared/ssl/dhparam.pem 2048
	cp etc/nginx/conf.d/homeland/ssl.conf.default etc/nginx/conf.d/homeland/ssl.conf
	$(RUN_WEB) bash -c '$(ACME) --installcert $(ACME_HOME) -d $$cert_domain --keypath /var/www/ssl/homeland.key --fullchainpath /var/www/ssl/homeland.crt --reloadcmd "nginx -s reload"'
	@echo "---------------------------------------------\n\nSSL install successed.\n\nNow you need enable https=true by update app.local.env.\nAnd then run: make restart\n\n"
update:
	@docker-compose pull
	@make secret
	@touch app.local.env
	@$(RUN) bundle exec rails db:migrate
	@$(RUN) bundle exec rails assets:precompile RAILS_ENV=production
	@make restart
	@make clean
restart:
	@sh ./scripts/restart-app
	@docker-compose stop web
	@docker-compose up -d web
start:
	@docker-compose up -d
status:
	@docker-compose ps
stop:
	@docker-compose stop web app app_backup worker
stop-all:
	@docker-compose down
console:
	@$(RUN) bundle exec rails console
reindex:
	@echo "Reindex ElasticSearch..."
	@$(RAKE) environment elasticsearch:import:model CLASS=Topic FORCE=y
	@$(RAKE) environment elasticsearch:import:model CLASS=Page FORCE=y
	@$(RAKE) environment elasticsearch:import:model CLASS=User FORCE=y
secret:
	@test -f app.secret.env || echo "secret_key_base=`openssl rand -hex 32`" > app.secret.env
	@cat app.secret.env
clean:
	@echo "Clean Docker images..."
	@docker ps -aqf status=exited | xargs docker rm && docker images -qf dangling=true | xargs docker rmi
