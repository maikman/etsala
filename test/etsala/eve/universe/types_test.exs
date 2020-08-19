defmodule Etsala.Eve.Universe.TypesTest do
  use Etsala.DataCase

  alias Etsala.Eve.Universe.Types

  describe "type_ids" do
    alias Etsala.Eve.Universe.Types.TypeIds

    @valid_attrs %{name: "some name", type_id: 42}
    @update_attrs %{name: "some updated name", type_id: 43}
    @invalid_attrs %{name: nil, type_id: nil}

    def type_ids_fixture(attrs \\ %{}) do
      {:ok, type_ids} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Types.create_type_ids()

      type_ids
    end

    test "list_type_ids/0 returns all type_ids" do
      type_ids = type_ids_fixture()
      assert Types.list_type_ids() == [type_ids]
    end

    test "get_type_ids!/1 returns the type_ids with given id" do
      type_ids = type_ids_fixture()
      assert Types.get_type_ids!(type_ids.id) == type_ids
    end

    test "create_type_ids/1 with valid data creates a type_ids" do
      assert {:ok, %TypeIds{} = type_ids} = Types.create_type_ids(@valid_attrs)
      assert type_ids.name == "some name"
      assert type_ids.type_id == 42
    end

    test "create_type_ids/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Types.create_type_ids(@invalid_attrs)
    end

    test "update_type_ids/2 with valid data updates the type_ids" do
      type_ids = type_ids_fixture()
      assert {:ok, %TypeIds{} = type_ids} = Types.update_type_ids(type_ids, @update_attrs)
      assert type_ids.name == "some updated name"
      assert type_ids.type_id == 43
    end

    test "update_type_ids/2 with invalid data returns error changeset" do
      type_ids = type_ids_fixture()
      assert {:error, %Ecto.Changeset{}} = Types.update_type_ids(type_ids, @invalid_attrs)
      assert type_ids == Types.get_type_ids!(type_ids.id)
    end

    test "delete_type_ids/1 deletes the type_ids" do
      type_ids = type_ids_fixture()
      assert {:ok, %TypeIds{}} = Types.delete_type_ids(type_ids)
      assert_raise Ecto.NoResultsError, fn -> Types.get_type_ids!(type_ids.id) end
    end

    test "change_type_ids/1 returns a type_ids changeset" do
      type_ids = type_ids_fixture()
      assert %Ecto.Changeset{} = Types.change_type_ids(type_ids)
    end
  end
end
