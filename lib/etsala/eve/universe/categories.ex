defmodule Etsala.Eve.Universe.Categories do
  @moduledoc """
  The Eve.Universe.Categories context.
  """

  import Ecto.Query, warn: false
  alias Etsala.Repo

  alias Etsala.Eve.Universe.Categories.Categories

  @doc """
  Returns the list of category.

  ## Examples

      iex> list_categories()
      [%Categories{}, ...]

  """
  def list_categories do
    Repo.all(Categories)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Type ids does not exist.

  ## Examples

      iex> get_category!(123)
      %Categories{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Categories, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Categories{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Categories{}
    |> Categories.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Categories{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Categories{} = category, attrs) do
    category
    |> Categories.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Categories{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Categories{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Categories{}}

  """
  def change_category(%Categories{} = category) do
    Categories.changeset(category, %{})
  end

  def get_category_by_category_id(category_id) do
    Repo.get_by(Categories, category_id: category_id)
  end

  def get_category_by_name(name) do
    Repo.get_by(Categories, name: name)
  end

  def insert_or_update_category(attrs) do
    get_category_by_category_id(attrs["category_id"])
    |> case do
      nil -> create_category(attrs)
      order -> update_category(order, attrs)
    end
  end

  def search_category(query) do
    Repo.all(
      Categories
      |> where([p], ilike(p.name, ^"%#{String.replace(query, "%", "\\%")}%"))
    )
  end
end
