#!/bin/bash

cd ~/etsala
echo "PULL REPO"
git pull origin master
echo "KILL SERVER"
ps aux | grep elixir | grep -v grep | awk '{print $2}' | xargs kill
echo "EXECUTE MIGRATIONS"
mix ecto.migrate
echo "DEPLOY ASSETS"
npm install --prefix assets
npm rebuild node-sass --prefix assets
npm --prefix ./assets ci --progress=false --no-audit --loglevel=error
npm run --prefix ./assets deploy
mix phx.digest
echo "START SERVER"
PORT=80 elixir --erl "-detached" -S mix phx.server
echo "SERVER RUNNING"