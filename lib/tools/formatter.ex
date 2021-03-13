defmodule Tools.Formatter do
  def format_price(price) do
    {cast, ""} = "#{price}" |> Float.parse()
    cast |> Decimal.from_float() |> Decimal.round(2)
  end

  def encode_name(name) when is_binary(name), do: URI.encode(String.replace(name, " ", "_"))
  def encode_name(_), do: ""
  def decode_name(name) when is_binary(name), do: URI.decode(String.replace(name, "_", " "))
  def decode_name(_), do: ""

  def to_date(date_time) do
    {:ok, foo, _} = DateTime.from_iso8601(date_time)
    foo |> DateTime.to_date() |> Date.to_string()
  end
end
