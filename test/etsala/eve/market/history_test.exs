defmodule Etsala.Eve.Market.HistoryTest do
  use Etsala.DataCase

  alias Etsala.Eve.Market.History

  describe "order_history" do
    alias Etsala.Eve.Market.History.History

    @valid_attrs %{average_order_count: 42, average_price: 120.5, average_volume: 42, region_id: 42, type_id: 42}
    @update_attrs %{average_order_count: 43, average_price: 456.7, average_volume: 43, region_id: 43, type_id: 43}
    @invalid_attrs %{average_order_count: nil, average_price: nil, average_volume: nil, region_id: nil, type_id: nil}

    def history_fixture(attrs \\ %{}) do
      {:ok, history} =
        attrs
        |> Enum.into(@valid_attrs)
        |> History.create_history()

      history
    end

    test "list_order_history/0 returns all order_history" do
      history = history_fixture()
      assert History.list_order_history() == [history]
    end

    test "get_history!/1 returns the history with given id" do
      history = history_fixture()
      assert History.get_history!(history.id) == history
    end

    test "create_history/1 with valid data creates a history" do
      assert {:ok, %History{} = history} = History.create_history(@valid_attrs)
      assert history.average_order_count == 42
      assert history.average_price == 120.5
      assert history.average_volume == 42
      assert history.region_id == 42
      assert history.type_id == 42
    end

    test "create_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = History.create_history(@invalid_attrs)
    end

    test "update_history/2 with valid data updates the history" do
      history = history_fixture()
      assert {:ok, %History{} = history} = History.update_history(history, @update_attrs)
      assert history.average_order_count == 43
      assert history.average_price == 456.7
      assert history.average_volume == 43
      assert history.region_id == 43
      assert history.type_id == 43
    end

    test "update_history/2 with invalid data returns error changeset" do
      history = history_fixture()
      assert {:error, %Ecto.Changeset{}} = History.update_history(history, @invalid_attrs)
      assert history == History.get_history!(history.id)
    end

    test "delete_history/1 deletes the history" do
      history = history_fixture()
      assert {:ok, %History{}} = History.delete_history(history)
      assert_raise Ecto.NoResultsError, fn -> History.get_history!(history.id) end
    end

    test "change_history/1 returns a history changeset" do
      history = history_fixture()
      assert %Ecto.Changeset{} = History.change_history(history)
    end
  end
end
