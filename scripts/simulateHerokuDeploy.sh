#!/bin/sh

echo "Cleaning node_modules and bower_components"
rm -rf node_modules/*
rm -rf bower_components/*

npm install --production
bower install --allow-root

coffee startServer.coffee
