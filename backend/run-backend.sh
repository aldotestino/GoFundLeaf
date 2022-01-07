#!/bin/bash

sleep 15
echo "--> Running migration..."
npm run prisma:migrate-dev --name init
echo "--> Running generation..."
npm run prisma:generate
echo "--> Server starting..."
npm run dev