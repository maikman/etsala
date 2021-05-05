defmodule Etsala.Eve.CalendarTest do
  use Etsala.DataCase

  alias Etsala.Eve.Calendar

  describe "calendar" do
    alias Etsala.Eve.Calendar.Calendar

    @valid_attrs %{event_date: "2010-04-17T14:00:00Z", event_id: 42, event_response: "some event_response", importance: true, title: "some title", type: "some type"}
    @update_attrs %{event_date: "2011-05-18T15:01:01Z", event_id: 43, event_response: "some updated event_response", importance: false, title: "some updated title", type: "some updated type"}
    @invalid_attrs %{event_date: nil, event_id: nil, event_response: nil, importance: nil, title: nil, type: nil}

    def calendar_fixture(attrs \\ %{}) do
      {:ok, calendar} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calendar.create_calendar()

      calendar
    end

    test "list_calendar/0 returns all calendar" do
      calendar = calendar_fixture()
      assert Calendar.list_calendar() == [calendar]
    end

    test "get_calendar!/1 returns the calendar with given id" do
      calendar = calendar_fixture()
      assert Calendar.get_calendar!(calendar.id) == calendar
    end

    test "create_calendar/1 with valid data creates a calendar" do
      assert {:ok, %Calendar{} = calendar} = Calendar.create_calendar(@valid_attrs)
      assert calendar.event_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert calendar.event_id == 42
      assert calendar.event_response == "some event_response"
      assert calendar.importance == true
      assert calendar.title == "some title"
      assert calendar.type == "some type"
    end

    test "create_calendar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calendar.create_calendar(@invalid_attrs)
    end

    test "update_calendar/2 with valid data updates the calendar" do
      calendar = calendar_fixture()
      assert {:ok, %Calendar{} = calendar} = Calendar.update_calendar(calendar, @update_attrs)
      assert calendar.event_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert calendar.event_id == 43
      assert calendar.event_response == "some updated event_response"
      assert calendar.importance == false
      assert calendar.title == "some updated title"
      assert calendar.type == "some updated type"
    end

    test "update_calendar/2 with invalid data returns error changeset" do
      calendar = calendar_fixture()
      assert {:error, %Ecto.Changeset{}} = Calendar.update_calendar(calendar, @invalid_attrs)
      assert calendar == Calendar.get_calendar!(calendar.id)
    end

    test "delete_calendar/1 deletes the calendar" do
      calendar = calendar_fixture()
      assert {:ok, %Calendar{}} = Calendar.delete_calendar(calendar)
      assert_raise Ecto.NoResultsError, fn -> Calendar.get_calendar!(calendar.id) end
    end

    test "change_calendar/1 returns a calendar changeset" do
      calendar = calendar_fixture()
      assert %Ecto.Changeset{} = Calendar.change_calendar(calendar)
    end
  end
end
