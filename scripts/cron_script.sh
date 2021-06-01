#!/bin/bash

function import_order_history {
  echo "$(timestamp) start import order history"
  /usr/bin/mix run /root/etsala/scripts/order_history.exs
  echo "$(timestamp) import finished"
}

function import_orders {
  echo "$(timestamp) start import orders"
  /usr/bin/mix run /root/etsala/scripts/orders.exs
  echo "$(timestamp) import finished"
}

function import_types {
  echo "$(timestamp) start import types"
  /usr/bin/mix run /root/etsala/scripts/types.exs
  echo "$(timestamp) import finished"
}

function import_groups {
  echo "$(timestamp) start import groups"
  /usr/bin/mix run /root/etsala/scripts/groups.exs
  echo "$(timestamp) import finished"
}

function import_categories {
  echo "$(timestamp) start import categories"
  /usr/bin/mix run /root/etsala/scripts/categories.exs
  echo "$(timestamp) import finished"
}

function import_systems {
  echo "$(timestamp) start import systems"
  /usr/bin/mix run /root/etsala/scripts/systems.exs
  echo "$(timestamp) import finished"
}

timestamp() {
  date +"%Y-%m-%d:%H-%M-%S" # current time
}

source /root/etsala/scripts/vars.sh

cd /root/etsala
$1