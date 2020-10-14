defmodule Tools.Formatter do
  def format_price(price) do
    {cast, ""} = "#{price}" |> Float.parse()
    cast |> Decimal.from_float() |> Decimal.round(2)
  end

  def encode_name(name), do: URI.encode(String.replace(name, " ", "_"))
  def decode_name(name), do: URI.decode(String.replace(name, "_", " "))
end
