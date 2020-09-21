#!/bin/bash

function import_order_history {
  echo "$(timestamp) start import order history"
  /lib/elixir/bin/mix run /root/etsala/scripts/order_history.exs
  echo "$(timestamp) import finished"
}

function import_orders {
  echo "$(timestamp) start import orders"
  /lib/elixir/bin/mix run /root/etsala/scripts/orders.exs
  echo "$(timestamp) import finished"
}

function import_types {
  echo "$(timestamp) start import types"
  /lib/elixir/bin/mix run /root/etsala/scripts/types.exs
  echo "$(timestamp) import finished"
}

function import_systems {
  echo "$(timestamp) start import systems"
  /lib/elixir/bin/mix run /root/etsala/scripts/systems.exs
  echo "$(timestamp) import finished"
}

timestamp() {
  date +"%Y-%m-%d:%H-%M-%S" # current time
}


cd /root/etsala
MIX_ENV=prod $1