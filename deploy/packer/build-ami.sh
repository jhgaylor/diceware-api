#!/bin/sh
# API_VERSION=$(node -p -e "require('../../api-app/package.json').version")
# UI_VERSION=$(node -p -e "require('../../ui-app/package.json').version")

# Grab cookbooks from berksfiles - this is solo silliness
# The 'chef exec' assumes that you've used the chefdk
pushd ../chef/cookbooks
  for dir in $(ls); do
    echo "${dir} about to start"
    chef exec berks vendor --berksfile ${dir}/Berksfile ../vendor/cookbooks
    echo "${dir} finished"
  done
popd

# packer build -var "api_version=${API_VERSION}" -var "ui_version=${UI_VERSION}" app.json
packer build app.json