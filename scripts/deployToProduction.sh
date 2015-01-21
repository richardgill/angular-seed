#!/bin/sh
echo "Trying to add  git remote for angular-seed \n"
heroku git:remote --app angular-seed -r heroku_production

echo "Deploying to production \n"
git push heroku_production master
