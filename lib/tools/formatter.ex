defmodule Tools.Formatter do
  def format_price(price) do
    {:ok, cast} = price |> Decimal.cast()
    cast |> Decimal.round(2)
  end
end
