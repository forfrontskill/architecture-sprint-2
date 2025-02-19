#!/bin/bash

###
# Инициализируем бд
###

# docker exec -it configSrv mongosh --port 27017 --eval 'rs.initiate({ _id: "config_server", configsvr: true, members: [{ _id: 0, host: "configSrv:27017" }] }); exit();'

# docker compose exec -i shard1 mongosh --port 27018 --quiet --eval 'rs.initiate({ _id: "shard1", members: [{ _id: 0, host: "shard1:27018" }] }); exit();'

# docker compose exec -it shard2 mongosh --port 27019 --quiet --eval 'rs.initiate({ _id: "shard2", members: [{ _id: 1, host: "shard2:27019" }] }); exit();'

# docker exec -it mongos_router mongosh --port 27020 --quiet --eval 'sh.addShard("shard1/shard1:27018"); sh.addShard("shard2/shard2:27019"); sh.enableSharding("somedb"); sh.shardCollection("somedb.helloDoc", { "name" : "hashed" }); use somedb; for (var i = 0; i < 1000; i++) db.helloDoc.insert({age: i, name: "ly" + i}); db.helloDoc.countDocuments(); exit();'

docker exec -it mongos_router \
  mongosh --port 27020 --quiet --eval '
    sh.addShard("shard1/shard1:27018");
    sh.addShard("shard2/shard2:27019");
    sh.enableSharding("somedb");
    sh.shardCollection("somedb.helloDoc", { name: "hashed" });

    // Переходим к нужной БД без use somedb
    let db2 = db.getSiblingDB("somedb");

    // Заполняем коллекцию
    for (let i = 0; i < 1000; i++) {
      db2.helloDoc.insert({ age: i, name: "ly" + i });
    }

    // Выводим количество документов
    print(db2.helloDoc.countDocuments());

    // Завершаем сессию
    quit();
  '
