```bash
cd ruby-china
docker-compose build
docker-compose run web bundle exec rails db:create
docker-compose run web bundle exec rails db:migrate
docker-compose run web bundle exec rails assets:precompile
```

## 启动

```bash
docker-compose up -d
```

## 重启

```bash
docker-compose restart
```

## 停止

```bash
docker-compose down
```