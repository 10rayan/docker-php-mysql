#!/bin/sh

echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_TEST_DATABASE\` ;" | "${mysql[@]}"

"${mysql[@]}" < /docker-entrypoint-initdb.d/sample_db.sql
