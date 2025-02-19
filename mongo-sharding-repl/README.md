Итоговый файл схемы:
[Файл DrawIO со скетчем архитектуры](/task1.drawio)


# pymongo-api

## Как запустить
В каждом этапе mongo-sharding, mongo-sharding-repl, sharding-repl-cache выполнить следующие процедуры запуска:

Запускаем mongodb и приложение
```shell
docker compose up -d
```

Заполняем mongodb данными

```shell
./scripts/mongo-init.sh
```
В случае ошибки "MongoNetworkError: connect ECONNREFUSED 127.0.0.1:27020" повторить запуск скрипта.

## Как проверить

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs