defmodule HackerNews.StoryTest do
  use HackerNews.DataCase

  alias HackerNews.Story

  describe "storycontrollers" do
    alias HackerNews.Story.StoryController

    @valid_attrs %{by: "some by", descendants: "120.5", kids: [], score: "120.5", time: ~T[14:00:00], title: "some title", type: "some type", url: "some url"}
    @update_attrs %{by: "some updated by", descendants: "456.7", kids: [], score: "456.7", time: ~T[15:01:01], title: "some updated title", type: "some updated type", url: "some updated url"}
    @invalid_attrs %{by: nil, descendants: nil, kids: nil, score: nil, time: nil, title: nil, type: nil, url: nil}

    def story_controller_fixture(attrs \\ %{}) do
      {:ok, story_controller} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Story.create_story_controller()

      story_controller
    end

    test "list_storycontrollers/0 returns all storycontrollers" do
      story_controller = story_controller_fixture()
      assert Story.list_storycontrollers() == [story_controller]
    end

    test "get_story_controller!/1 returns the story_controller with given id" do
      story_controller = story_controller_fixture()
      assert Story.get_story_controller!(story_controller.id) == story_controller
    end

    test "create_story_controller/1 with valid data creates a story_controller" do
      assert {:ok, %StoryController{} = story_controller} = Story.create_story_controller(@valid_attrs)
      assert story_controller.by == "some by"
      assert story_controller.descendants == Decimal.new("120.5")
      assert story_controller.kids == []
      assert story_controller.score == Decimal.new("120.5")
      assert story_controller.time == ~T[14:00:00]
      assert story_controller.title == "some title"
      assert story_controller.type == "some type"
      assert story_controller.url == "some url"
    end

    test "create_story_controller/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Story.create_story_controller(@invalid_attrs)
    end

    test "update_story_controller/2 with valid data updates the story_controller" do
      story_controller = story_controller_fixture()
      assert {:ok, %StoryController{} = story_controller} = Story.update_story_controller(story_controller, @update_attrs)
      assert story_controller.by == "some updated by"
      assert story_controller.descendants == Decimal.new("456.7")
      assert story_controller.kids == []
      assert story_controller.score == Decimal.new("456.7")
      assert story_controller.time == ~T[15:01:01]
      assert story_controller.title == "some updated title"
      assert story_controller.type == "some updated type"
      assert story_controller.url == "some updated url"
    end

    test "update_story_controller/2 with invalid data returns error changeset" do
      story_controller = story_controller_fixture()
      assert {:error, %Ecto.Changeset{}} = Story.update_story_controller(story_controller, @invalid_attrs)
      assert story_controller == Story.get_story_controller!(story_controller.id)
    end

    test "delete_story_controller/1 deletes the story_controller" do
      story_controller = story_controller_fixture()
      assert {:ok, %StoryController{}} = Story.delete_story_controller(story_controller)
      assert_raise Ecto.NoResultsError, fn -> Story.get_story_controller!(story_controller.id) end
    end

    test "change_story_controller/1 returns a story_controller changeset" do
      story_controller = story_controller_fixture()
      assert %Ecto.Changeset{} = Story.change_story_controller(story_controller)
    end
  end
end
