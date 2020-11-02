defmodule Etsala.Eve.Market.Order do
  @moduledoc """
  The Eve.Market.Order context.
  """

  import Ecto.Query, warn: false
  alias Etsala.Repo

  alias Etsala.Eve.Market.Order.Order

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{source: %Order{}}

  """
  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end

  def insert_or_update_order(attrs) do
    get_order_by_order_id(attrs["order_id"])
    |> case do
      nil -> create_order(attrs)
      order -> update_order(order, attrs)
    end
  end

  def get_order_by_order_id(order_id) do
    Repo.get_by(Order, order_id: order_id)
  end

  def get_order_by_location_id(id) do
    Order
    |> where([order], order.location_id == ^id)
    |> Repo.all()
  end

  def get_order_by_type_id(id) do
    Order
    |> where([order], order.type_id == ^id)
    |> Repo.all()
  end

  def get_sell_order_by_type_id(id) do
    Order
    |> where([order], order.type_id == ^id)
    |> where([order], order.is_buy_order == false)
    |> Repo.all()
  end

  def get_buy_order_by_type_id(id) do
    Order
    |> where([order], order.type_id == ^id)
    |> where([order], order.is_buy_order == true)
    |> Repo.all()
  end
end
