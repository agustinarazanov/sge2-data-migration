MYSQL_ROOT_PASSWORD=0123456789
docker run --name mysql -p 3306:3306 --rm -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e MYSQL_DATABASE=sge2 -d mysql:9.0.1
docker cp $(pwd)/dump.sql mysql:/dumpfile.sql
echo "Waiting for mysql to start..."
sleep 10
docker exec -i mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" sge2 < /dumpfile.sql'
npm install
npm run build
npm start
npx prisma generate
npx prisma db push
npx prisma generate --sql
npx ts-node script.ts 
docker stop mysql
