defmodule Tools.LogBackend.CustomLogFormatter do
  @moduledoc """
    format custom logs in dev mode to show related metadata
  """
  require Logger

  def format(_level, "custom_log", _timestamp, metadata) do
    "[CUSTOM_LOG] #{inspect(metadata[:custom_log_name])}: #{
      inspect(metadata[:custom_log_message])
    }\n"
  rescue
    _ -> "could not format message: custom_log\n"
  end

  def format(level, message, timestamp, metadata) do
    "[#{level}] #{message}\n"
  rescue
    _ -> "could not format message: #{inspect({level, message, timestamp, metadata})}\n"
  end
end
