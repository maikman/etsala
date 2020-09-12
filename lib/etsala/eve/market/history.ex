defmodule Etsala.Eve.Market.History do
  @moduledoc """
  The Eve.Market.History context.
  """

  import Ecto.Query, warn: false
  alias Etsala.Repo

  alias Etsala.Eve.Market.History.History

  @doc """
  Returns the list of order_history.

  ## Examples

      iex> list_order_history()
      [%History{}, ...]

  """
  def list_order_history do
    Repo.all(History)
  end

  @doc """
  Gets a single history.

  Raises `Ecto.NoResultsError` if the History does not exist.

  ## Examples

      iex> get_history!(123)
      %History{}

      iex> get_history!(456)
      ** (Ecto.NoResultsError)

  """
  def get_history!(id), do: Repo.get!(History, id)

  @doc """
  Creates a history.

  ## Examples

      iex> create_history(%{field: value})
      {:ok, %History{}}

      iex> create_history(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_history(attrs \\ %{}) do
    %History{}
    |> History.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a history.

  ## Examples

      iex> update_history(history, %{field: new_value})
      {:ok, %History{}}

      iex> update_history(history, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_history(%History{} = history, attrs) do
    history
    |> History.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a history.

  ## Examples

      iex> delete_history(history)
      {:ok, %History{}}

      iex> delete_history(history)
      {:error, %Ecto.Changeset{}}

  """
  def delete_history(%History{} = history) do
    Repo.delete(history)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking history changes.

  ## Examples

      iex> change_history(history)
      %Ecto.Changeset{source: %History{}}

  """
  def change_history(%History{} = history) do
    History.changeset(history, %{})
  end

  def insert_or_update_history(attrs) do
    get_history_by_type_id_and_region_id(attrs.type_id, attrs.region_id)
    |> case do
      nil -> create_history(attrs)
      order -> update_history(order, attrs)
    end
  end

  def get_history_by_type_id_and_region_id(type_id, region_id) do
    Repo.get_by(History, type_id: type_id, region_id: region_id)
  end

  def get_maximums() do
    [mp, moc, mv] =
      from(h in History,
        select: [max(h.average_price), max(h.average_order_count), max(h.average_volume)]
      )
      |> Repo.one()

    %{
      max_price: mp,
      max_order_count: moc,
      max_volume: mv
    }
  end
end
