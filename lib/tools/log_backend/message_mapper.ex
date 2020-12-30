defmodule Tools.LogBackend.MessageMapper do
  @moduledoc """
  handle and format log messages catched by the Log Backend
  """

  alias Tools.LogBackend.RequestLogger

  def handle_log({level, message, metadata}) do
    process(level, message, metadata)
  end

  defp process(:info, "router_error", metadata) do
    RequestLogger.handle_request(Enum.into(metadata, %{}))
  end

  defp process(_, _, _), do: {nil, :noop}
end
