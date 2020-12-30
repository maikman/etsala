defmodule Tools.LogBackend.Helper do
  @moduledoc """
  handling all kind of data structures
  """

  def replace_structs(%{__struct__: _} = struct) do
    struct
    |> Map.from_struct()
    |> Map.put(:struct_name, Atom.to_string(struct.__struct__))
    |> replace_structs()
  end

  def replace_structs(map) when is_map(map) do
    map
    |> Map.to_list()
    |> replace_structs()
    |> Map.new()
  end

  def replace_structs(list) when is_list(list) do
    list
    |> Enum.map(fn
      # for keyword lists
      {k, v} -> {k, replace_structs(v)}
      # for normal lists
      v -> replace_structs(v)
    end)
  end

  def replace_structs(tuple) when is_tuple(tuple) do
    tuple
    |> Tuple.to_list()
    |> replace_structs()
  end

  def replace_structs(val), do: val
end
