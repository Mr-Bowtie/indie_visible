#!/bin/sh

set -e

bundle check || bundle install
yarn install

bin/vite dev
