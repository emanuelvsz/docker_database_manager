echo "\
+----------------------------------+
| Loading environment variables... |
+----------------------------------+\
"
source .env
schema=$(echo $DATABASE_SCHEMA | sed "s/\r//")
user=$(echo $DATABASE_USER | sed "s/\r//")
password=$(echo $DATABASE_PASSWORD | sed "s/\r//")
host=$(echo $DATABASE_HOST | sed "s/\r//")
port=$(echo $DATABASE_PORT | sed "s/\r//")
name=$(echo $DATABASE_NAME | sed "s/\r//")
sslmode=$(echo $DATABASE_SSL_MODE | sed "s/\r//")
migrations_path=$(echo $DATABASE_MIGRATIONS_PATH | sed "s/\r//")
uri="$schema://$user:$password@$host:$port/$name?sslmode=$sslmode"

echo "\
+----------------------+
| Starting database... |
+----------------------+\
"
cd tools/database
docker compose rm -sf && docker compose up --build -d
cd ../..


echo "\
+--------------------------------------------------------+
| Waiting 5 seconds so that the database can initiate... |
+--------------------------------------------------------+\
"
sleep 3

echo "\
+-----------------------+
| Loading migrations... |
+-----------------------+\
"
migrate -path $migrations_path -database $uri up
