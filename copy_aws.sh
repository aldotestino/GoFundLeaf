#! /bin/bash

rsync -av -e "ssh -i ../leaf02-group43.cer" --exclude='.idea' --exclude='.DS_Store' --exclude='frontend' --exclude='readme-images' --exclude='backend/node_modules' --exclude='.git' $(pwd) ubuntu@13.237.239.119:/home/ubuntu/