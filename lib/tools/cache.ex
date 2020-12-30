defmodule Tools.Cache do
  require Logger

  def insert({key, value}, table) do
    Logger.debug("insert (#{key}) into #{table}")

    :ets.whereis(table)
    |> is_reference()
    |> insert({key, value}, table)
  end

  defp insert(true, {key, value}, table), do: :ets.insert(table, {key, value})
  defp insert(false, {key, value}, table), do: create_table_and_insert(table, {key, value})

  def get_one(key, table) do
    Logger.debug("get_one (#{key}) from #{table}")

    :ets.whereis(table)
    |> case do
      :undefined -> create_table_and_lookup(table)
      _ -> :ets.lookup(table, key)
    end
  end

  def get_all(table) do
  end

  defp create_table_and_insert(table, {key, value}) do
    Logger.debug("create_table_and_insert - #{table}")

    :ets.new(table, [:named_table, :public])
    :ets.insert(table, {key, value})
  end

  defp create_table_and_lookup(table) do
    Logger.debug("create_table_and_lookup - #{table}")
    :ets.new(table, [:named_table, :public])
    []
  end
end
