#!/bin/sh

set -e

bundle check || bundle install

# server isnt shutting down nicely and managing this file lock, so Im manually doing it for now
file_path="./tmp/pids/server.pid" # Replace with the actual path to your file

if [ -e "$file_path" ]; then
	rm "$file_path"
	echo "File deleted: $file_path"
else
	echo "No server lock to worry about"
fi

echo "=========== FRESH = $FRESH ============="

if [ "$FRESH" = "true" ]; then
	echo "======= Refreshing Container Setup ======="
	bin/container_setup
fi

echo "======= Starting Rails server ======="
bin/rails s -b 0.0.0.0
