#!/bin/bash

remote=`git remote -v | awk '/\(push\)$/ {print $2}'`
email=dfwarden@gmail.com # default

echo "Remote is ${remote}, deciding which email address to use."

if [[ "${remote}" == "*geneseo.edu*" ]]; then
    email=warden@geneseo.edu
    # Use Geneseo signing key
    git config user.signingKey 0x4B89C54E5455EA50
fi

echo "Configuring user.email as $email"
git config user.email $email
