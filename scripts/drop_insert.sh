npx prisma db execute --file scripts/drop.sql
npx prisma generate
npx prisma db push
npx ts-node scripts/script.ts
