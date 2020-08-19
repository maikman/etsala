defmodule Etsala.Eve.Market.OrderTest do
  use Etsala.DataCase

  alias Etsala.Eve.Market.Order

  describe "orders" do
    alias Etsala.Eve.Market.Order.Order

    @valid_attrs %{duration: 42, is_buy_order: true, issued: "some issued", location_id: 42, min_volume: 42, order_id: 42, price: 120.5, range: "some range", system_id: 42, type_id: 42, volume_remain: 42, volume_total: 42}
    @update_attrs %{duration: 43, is_buy_order: false, issued: "some updated issued", location_id: 43, min_volume: 43, order_id: 43, price: 456.7, range: "some updated range", system_id: 43, type_id: 43, volume_remain: 43, volume_total: 43}
    @invalid_attrs %{duration: nil, is_buy_order: nil, issued: nil, location_id: nil, min_volume: nil, order_id: nil, price: nil, range: nil, system_id: nil, type_id: nil, volume_remain: nil, volume_total: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Order.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Order.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Order.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Order.create_order(@valid_attrs)
      assert order.duration == 42
      assert order.is_buy_order == true
      assert order.issued == "some issued"
      assert order.location_id == 42
      assert order.min_volume == 42
      assert order.order_id == 42
      assert order.price == 120.5
      assert order.range == "some range"
      assert order.system_id == 42
      assert order.type_id == 42
      assert order.volume_remain == 42
      assert order.volume_total == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Order.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Order.update_order(order, @update_attrs)
      assert order.duration == 43
      assert order.is_buy_order == false
      assert order.issued == "some updated issued"
      assert order.location_id == 43
      assert order.min_volume == 43
      assert order.order_id == 43
      assert order.price == 456.7
      assert order.range == "some updated range"
      assert order.system_id == 43
      assert order.type_id == 43
      assert order.volume_remain == 43
      assert order.volume_total == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Order.update_order(order, @invalid_attrs)
      assert order == Order.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Order.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Order.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Order.change_order(order)
    end
  end
end
