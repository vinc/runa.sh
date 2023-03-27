#!/bin/bash

set -e

APP_DIR=${APP_DIR:-"$HOME/runa"}

main() {
  case "$1" in
    "service-init") service-init "$2";;
    "service-exec") service-exec "$2";;
  esac
}

service-init() {
  if [ ! -d "$APP_DIR" ]; then
    git clone https://github.com/vinc/runa.sh "$APP_DIR"
    cd "$APP_DIR"
    cp .env.sample .env
    $EDITOR .env
  else
    cd "$APP_DIR"
    git fetch
    git rebase
  fi
  asdf install
  gem install bundler
  bundle install
  if [ "$1" == "web" ]; then
    npm install yarn -g
    yarn install
    yarn build
    yarn build:css
    bundle exec rails db:prepare
  fi
}

service-exec() {
  cd "$APP_DIR"
  source .env
  case "$1" in
    "web") bundle exec rails server -b 0.0.0.0;;
    "job") bundle exec good_job start --queues "default:8;run_xs:8;run_sm:4;run_md:2;run_lg:1";;
    *) echo "Could not execute service: $1" && exit 1;;
  esac
}

main "$@"
