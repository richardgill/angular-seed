#!/bin/sh
echo "\nFinger print error? See: http://stackoverflow.com/questions/8786564/cannot-push-to-heroku-because-key-fingerprint \n\n"

echo "Trying to add  git remote for angular-seed-dev \n"
heroku git:remote --app angular-seed-dev -r heroku_dev

echo "Deploying to dev \n"
git push heroku_dev master
