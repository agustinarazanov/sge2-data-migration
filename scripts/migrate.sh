docker run --name mysql \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=0123456789 \
    -e MYSQL_DATABASE=sge2 \
    -v ./scripts/dump.sql:/docker-entrypoint-initdb.d/init.sql \
    -d mysql:9.0.1

# Migrate from MySQL to PostgreSQL
npm install
npm run build
npm start

# Migrate from old to public schema
npx prisma generate
npx prisma db push
npx prisma generate --sql
npx ts-node scripts/script.ts

# Stop and remove the MySQL container
docker stop mysql
