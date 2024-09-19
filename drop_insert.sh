npx prisma db execute --file drop.sql
npx prisma generate
npx prisma db push
npx ts-node script.ts
