defmodule Etsala.Eve.Universe.Groups do
  @moduledoc """
  The Eve.Universe.Groups context.
  """

  import Ecto.Query, warn: false
  alias Etsala.Repo

  alias Etsala.Eve.Universe.Groups.Groups

  @doc """
  Returns the list of group.

  ## Examples

      iex> list_groups()
      [%Groups{}, ...]

  """
  def list_groups do
    Repo.all(Groups)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Type ids does not exist.

  ## Examples

      iex> get_group!(123)
      %Groups{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Groups, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Groups{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Groups{}
    |> Groups.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Groups{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Groups{} = group, attrs) do
    group
    |> Groups.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Groups{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Groups{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{source: %Groups{}}

  """
  def change_group(%Groups{} = group) do
    Groups.changeset(group, %{})
  end

  def get_group_by_group_id(group_id) do
    Repo.get_by(Groups, group_id: group_id)
  end

  def get_group_by_name(name) do
    Repo.get_by(Groups, name: name)
  end

  def list_groups_by_category(category_id) do
    Repo.all(
      Groups
      |> where([p], p.category_id == ^category_id)
    )
  end

  def insert_or_update_group(attrs) do
    get_group_by_group_id(attrs["group_id"])
    |> case do
      nil -> create_group(attrs)
      order -> update_group(order, attrs)
    end
  end

  def search_group(query) do
    Repo.all(
      Groups
      |> where([p], ilike(p.name, ^"%#{String.replace(query, "%", "\\%")}%"))
    )
  end
end
