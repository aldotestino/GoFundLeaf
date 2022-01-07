#! /bin/bash

rsync -av -e "ssh -i ../leaf02-group43.cer" --exclude='frontend' --exlude='images' --exclude='database-data' --exclude='.git' $(pwd) ubuntu@13.237.239.119:/home/ubuntu/