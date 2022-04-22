#!/bin/bash

echo "removing the mariadb container"
docker rm -vf mariadb
echo "cleaning up persistent data..."
echo "removing the mariadb volume"
docker volume rm ch2db
