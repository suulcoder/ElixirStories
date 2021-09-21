defmodule HackerNews.NewTest do
  use HackerNews.DataCase

  alias HackerNews.New

  describe "newcontrollers" do
    alias HackerNews.New.NewController

    @valid_attrs %{by: "some by", descendants: "120.5", kids: [], score: "120.5", time: ~T[14:00:00], title: "some title", type: "some type", url: "some url"}
    @update_attrs %{by: "some updated by", descendants: "456.7", kids: [], score: "456.7", time: ~T[15:01:01], title: "some updated title", type: "some updated type", url: "some updated url"}
    @invalid_attrs %{by: nil, descendants: nil, kids: nil, score: nil, time: nil, title: nil, type: nil, url: nil}

    def new_controller_fixture(attrs \\ %{}) do
      {:ok, new_controller} =
        attrs
        |> Enum.into(@valid_attrs)
        |> New.create_new_controller()

      new_controller
    end

    test "list_newcontrollers/0 returns all newcontrollers" do
      new_controller = new_controller_fixture()
      assert New.list_newcontrollers() == [new_controller]
    end

    test "get_new_controller!/1 returns the new_controller with given id" do
      new_controller = new_controller_fixture()
      assert New.get_new_controller!(new_controller.id) == new_controller
    end

    test "create_new_controller/1 with valid data creates a new_controller" do
      assert {:ok, %NewController{} = new_controller} = New.create_new_controller(@valid_attrs)
      assert new_controller.by == "some by"
      assert new_controller.descendants == Decimal.new("120.5")
      assert new_controller.kids == []
      assert new_controller.score == Decimal.new("120.5")
      assert new_controller.time == ~T[14:00:00]
      assert new_controller.title == "some title"
      assert new_controller.type == "some type"
      assert new_controller.url == "some url"
    end

    test "create_new_controller/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = New.create_new_controller(@invalid_attrs)
    end

    test "update_new_controller/2 with valid data updates the new_controller" do
      new_controller = new_controller_fixture()
      assert {:ok, %NewController{} = new_controller} = New.update_new_controller(new_controller, @update_attrs)
      assert new_controller.by == "some updated by"
      assert new_controller.descendants == Decimal.new("456.7")
      assert new_controller.kids == []
      assert new_controller.score == Decimal.new("456.7")
      assert new_controller.time == ~T[15:01:01]
      assert new_controller.title == "some updated title"
      assert new_controller.type == "some updated type"
      assert new_controller.url == "some updated url"
    end

    test "update_new_controller/2 with invalid data returns error changeset" do
      new_controller = new_controller_fixture()
      assert {:error, %Ecto.Changeset{}} = New.update_new_controller(new_controller, @invalid_attrs)
      assert new_controller == New.get_new_controller!(new_controller.id)
    end

    test "delete_new_controller/1 deletes the new_controller" do
      new_controller = new_controller_fixture()
      assert {:ok, %NewController{}} = New.delete_new_controller(new_controller)
      assert_raise Ecto.NoResultsError, fn -> New.get_new_controller!(new_controller.id) end
    end

    test "change_new_controller/1 returns a new_controller changeset" do
      new_controller = new_controller_fixture()
      assert %Ecto.Changeset{} = New.change_new_controller(new_controller)
    end
  end
end
