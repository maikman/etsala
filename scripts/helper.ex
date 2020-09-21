defmodule Importer.Helper do
  require Logger

  def output_count(list \\ 0) do
    count = list |> Enum.count()
    Logger.info("processed #{count} items")
  end
end
