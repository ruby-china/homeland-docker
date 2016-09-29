```bash
cd ruby-china
docker-compose build
docker-compose run web bundle exec rails db:create
docker-compose run web bundle exec rails db:migrate
docker-compose run web bundle exec rails assets:precompile
```