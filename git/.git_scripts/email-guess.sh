#!/bin/bash

remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
email=dfwarden@gmail.com # default

if [[ $remote == *geneseo.edu* ]]; then
      email=warden@geneseo.edu
fi

echo "Configuring user.email as $email"
git config user.email $email
