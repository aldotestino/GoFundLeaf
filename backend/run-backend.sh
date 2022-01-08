#!/bin/bash

echo "--> Waiting for db..."
sleep 15
echo "--> Running migration..."
npm run prisma:migrate-dev --name init
echo "--> Server starting..."
npm start