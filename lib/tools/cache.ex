defmodule Tools.Cache do
  require Logger

  def insert({key, value}, table) do
    Logger.debug("insert - #{key} - #{table}")

    :ets.whereis(table)
    |> case do
      :undefined -> create_table_and_insert({key, value}, table)
      _ -> :ets.insert(table, {key, value})
    end
  end

  def get_one(key, table) do
    Logger.debug("get_one - #{key} - #{table}")

    :ets.whereis(table)
    |> case do
      :undefined -> create_table_and_lookup(table)
      _ -> :ets.lookup(table, key)
    end
  end

  def get_all(table) do
  end

  defp create_table_and_insert({key, value}, table) do
    Logger.debug("create_table_and_insert - #{table}")

    :ets.new(table, [:named_table])
    :ets.insert(table, {key, value})
  end

  defp create_table_and_lookup(table) do
    Logger.debug("create_table_and_lookup - #{table}")
    :ets.new(table, [:named_table])
    []
  end
end
