defmodule Etsala.Eve.Universe.SystemTest do
  use Etsala.DataCase

  alias Etsala.Eve.Universe.System

  describe "systems" do
    alias Etsala.Eve.Universe.System.System

    @valid_attrs %{name: "some name", system_id: 42}
    @update_attrs %{name: "some updated name", system_id: 43}
    @invalid_attrs %{name: nil, system_id: nil}

    def system_fixture(attrs \\ %{}) do
      {:ok, system} =
        attrs
        |> Enum.into(@valid_attrs)
        |> System.create_system()

      system
    end

    test "list_systems/0 returns all systems" do
      system = system_fixture()
      assert System.list_systems() == [system]
    end

    test "get_system!/1 returns the system with given id" do
      system = system_fixture()
      assert System.get_system!(system.id) == system
    end

    test "create_system/1 with valid data creates a system" do
      assert {:ok, %System{} = system} = System.create_system(@valid_attrs)
      assert system.name == "some name"
      assert system.system_id == 42
    end

    test "create_system/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = System.create_system(@invalid_attrs)
    end

    test "update_system/2 with valid data updates the system" do
      system = system_fixture()
      assert {:ok, %System{} = system} = System.update_system(system, @update_attrs)
      assert system.name == "some updated name"
      assert system.system_id == 43
    end

    test "update_system/2 with invalid data returns error changeset" do
      system = system_fixture()
      assert {:error, %Ecto.Changeset{}} = System.update_system(system, @invalid_attrs)
      assert system == System.get_system!(system.id)
    end

    test "delete_system/1 deletes the system" do
      system = system_fixture()
      assert {:ok, %System{}} = System.delete_system(system)
      assert_raise Ecto.NoResultsError, fn -> System.get_system!(system.id) end
    end

    test "change_system/1 returns a system changeset" do
      system = system_fixture()
      assert %Ecto.Changeset{} = System.change_system(system)
    end
  end
end
