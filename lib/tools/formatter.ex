defmodule Tools.Formatter do
  def format_price(price) do
    cast = price |> Decimal.cast()
    cast |> Decimal.round(2)
  end
end
