#!/bin/bash

cd ~/etsala
echo "PULL REPO"
git pull origin master
echo "KILL SERVER"
ps aux | grep elixir | grep -v grep | awk '{print $2}' | xargs kill
echo "RESTART SERVER"
PORT=80 elixir --erl "-detached" -S mix phx.server
echo "SERVER RUNNING"