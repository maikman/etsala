defmodule Etsala.Eve.Universe.Types do
  @moduledoc """
  The Eve.Universe.Types context.
  """

  import Ecto.Query, warn: false
  alias Etsala.Repo

  alias Etsala.Eve.Universe.Types.Types
  alias Tools.Cache

  @doc """
  Returns the list of type.

  ## Examples

      iex> list_types()
      [%Types{}, ...]

  """
  def list_types do
    Repo.all(Types)
  end

  @doc """
  Gets a single type.

  Raises `Ecto.NoResultsError` if the Type ids does not exist.

  ## Examples

      iex> get_type!(123)
      %Types{}

      iex> get_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_type!(id), do: Repo.get!(Types, id)

  @doc """
  Creates a type.

  ## Examples

      iex> create_type(%{field: value})
      {:ok, %Types{}}

      iex> create_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_type(attrs \\ %{}) do
    %Types{}
    |> Types.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a type.

  ## Examples

      iex> update_type(type, %{field: new_value})
      {:ok, %Types{}}

      iex> update_type(type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_type(%Types{} = type, attrs) do
    type
    |> Types.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a type.

  ## Examples

      iex> delete_type(type)
      {:ok, %Types{}}

      iex> delete_type(type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_type(%Types{} = type) do
    Repo.delete(type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking type changes.

  ## Examples

      iex> change_type(type)
      %Ecto.Changeset{source: %Types{}}

  """
  def change_type(%Types{} = type) do
    Types.changeset(type, %{})
  end

  def get_type_by_type_id(type_id) do
    Repo.get_by(Types, type_id: type_id)
  end

  def get_type_by_name(name) do
    Repo.get_by(Types, name: name)
  end

  def insert_or_update_type(attrs) do
    get_type_by_type_id(attrs["type_id"])
    |> case do
      nil -> create_type(attrs)
      order -> update_type(order, attrs)
    end
  end

  def search_type(query) do
    Repo.all(
      Types
      |> where([p], ilike(p.name, ^"%#{String.replace(query, "%", "\\%")}%"))
    )
  end

  def get_type_from_cache(type_id) do
    {:ok, result} =
      Cache.get_one(type_id, :types)
      |> case do
        [{_full_url, type}] -> {:ok, type}
        [] -> get_type_from_db(type_id)
        _ -> {:error, "Caching Error"}
      end

    result
  end

  defp get_type_from_db(type_id) do
    cache_all_types()

    name =
      get_type_by_type_id(type_id)
      |> case do
        nil -> %{}
        type -> type |> Map.from_struct()
      end

    {:ok, name}
  end

  defp cache_all_types() do
    list_types()
    |> Enum.each(&Cache.insert({&1.type_id, &1 |> Map.from_struct()}, :types))
  end
end
