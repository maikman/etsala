defmodule Tools.Importer do
  require Logger

  def output_count(list \\ 0, info \\ "-") do
    count = list |> Enum.count()
    Logger.info("processed #{count} items | #{info}")
  end
end
