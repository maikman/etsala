#!/bin/bash

function import_order_history {
  echo "start import order history"
  /lib/elixir/bin/mix run ~/etsala/scripts/order_history.exs
}


cd ~/etsala
$1