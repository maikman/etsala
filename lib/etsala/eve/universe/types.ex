defmodule Etsala.Eve.Universe.Types do
  @moduledoc """
  The Eve.Universe.Types context.
  """

  import Ecto.Query, warn: false
  alias Etsala.Repo

  alias Etsala.Eve.Universe.Types.TypeIds

  @doc """
  Returns the list of type_ids.

  ## Examples

      iex> list_type_ids()
      [%TypeIds{}, ...]

  """
  def list_type_ids do
    Repo.all(TypeIds)
  end

  @doc """
  Gets a single type_ids.

  Raises `Ecto.NoResultsError` if the Type ids does not exist.

  ## Examples

      iex> get_type_ids!(123)
      %TypeIds{}

      iex> get_type_ids!(456)
      ** (Ecto.NoResultsError)

  """
  def get_type_ids!(id), do: Repo.get!(TypeIds, id)

  @doc """
  Creates a type_ids.

  ## Examples

      iex> create_type_ids(%{field: value})
      {:ok, %TypeIds{}}

      iex> create_type_ids(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_type_ids(attrs \\ %{}) do
    %TypeIds{}
    |> TypeIds.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a type_ids.

  ## Examples

      iex> update_type_ids(type_ids, %{field: new_value})
      {:ok, %TypeIds{}}

      iex> update_type_ids(type_ids, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_type_ids(%TypeIds{} = type_ids, attrs) do
    type_ids
    |> TypeIds.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a type_ids.

  ## Examples

      iex> delete_type_ids(type_ids)
      {:ok, %TypeIds{}}

      iex> delete_type_ids(type_ids)
      {:error, %Ecto.Changeset{}}

  """
  def delete_type_ids(%TypeIds{} = type_ids) do
    Repo.delete(type_ids)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking type_ids changes.

  ## Examples

      iex> change_type_ids(type_ids)
      %Ecto.Changeset{source: %TypeIds{}}

  """
  def change_type_ids(%TypeIds{} = type_ids) do
    TypeIds.changeset(type_ids, %{})
  end

  def get_type_by_type_id(type_id) do
    Repo.get_by(TypeIds, type_id: type_id)
  end

  def insert_or_update_type(attrs) do
    get_type_by_type_id(attrs["type_id"])
    |> case do
      nil -> create_type_ids(attrs)
      order -> update_type_ids(order, attrs)
    end
  end
end
