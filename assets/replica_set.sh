#!/bin/bash
# TODO create a mongod user, use mongod user for everything
export MONGOPATH=/mongodb-3.0.4/mongodb-linux-x86_64-ubuntu1404-3.0.4/bin

killall mongod

rm -rf /data/rs1 /data/rs2 /data/rs3 /tmp/replset

mkdir -p /data/rs1 /data/rs2 /data/rs3 /tmp/replset

$MONGOPATH/mongod --replSet rs0 --logpath /tmp/replset/1.log --dbpath /data/rs1 --port 27017 --oplogSize 2 --fork --nojournal --smallfiles
$MONGOPATH/mongod --replSet rs0 --logpath /tmp/replset/2.log --dbpath /data/rs2 --port 27018 --oplogSize 2 --fork --nojournal --smallfiles
$MONGOPATH/mongod --replSet rs0 --logpath /tmp/replset/3.log --dbpath /data/rs3 --port 27019 --oplogSize 2 --fork --nojournal --smallfiles

sleep 3 

HOSTNAME="$(hostname)"

sleep 30
$MONGOPATH/mongo --eval 'printjson(rs.initiate({ "_id": "rs0", "members" : [{ "_id" : 0, "host" : "127.0.0.1:27017" },{ "_id" : 1, "host" : "127.0.0.1:27018" },{ "_id" : 2, "host" : "127.0.0.1:27019" } ]}))'
sleep 45

$MONGOPATH/mongo --eval "for (i = 0; i < 1000; i++ ) db.col.insert( { val : 'a' })"

sleep 10

$MONGOPATH/mongo --port 27019 --eval "db.adminCommand( { shutdown : 1 })"

sleep 10

$MONGOPATH/mongo --eval "for (i = 0; i < 200000; i++ ) db.col.insert( { val : 'a' })"

$MONGOPATH/mongod --replSet rs0 --logpath /tmp/replset/3.log --dbpath /data/rs3 --port 27019 --oplogSize 2 --fork --nojournal --smallfiles
