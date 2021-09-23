defmodule HackerNews.StoryTest do
  use HackerNews.DataCase

  alias HackerNews.Story

  describe "hackernews" do
    alias HackerNews.Story.HackerNew

    @valid_attrs %{by: "some by", descendants: "120.5", kids: [], score: "120.5", time: "120.5", title: "some title", type: "some type", url: "some url"}
    @update_attrs %{by: "some updated by", descendants: "456.7", kids: [], score: "456.7", time: "456.7", title: "some updated title", type: "some updated type", url: "some updated url"}
    @invalid_attrs %{by: nil, descendants: nil, kids: nil, score: nil, time: nil, title: nil, type: nil, url: nil}

    def hacker_new_fixture(attrs \\ %{}) do
      {:ok, hacker_new} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Story.create_hacker_new()

      hacker_new
    end

    test "list_hackernews/0 returns all hackernews" do
      hacker_new = hacker_new_fixture()
      assert Story.list_hackernews() == [hacker_new]
    end

    test "get_hacker_new!/1 returns the hacker_new with given id" do
      hacker_new = hacker_new_fixture()
      assert Story.get_hacker_new!(hacker_new.id) == hacker_new
    end

    test "create_hacker_new/1 with valid data creates a hacker_new" do
      assert {:ok, %HackerNew{} = hacker_new} = Story.create_hacker_new(@valid_attrs)
      assert hacker_new.by == "some by"
      assert hacker_new.descendants == Decimal.new("120.5")
      assert hacker_new.kids == []
      assert hacker_new.score == Decimal.new("120.5")
      assert hacker_new.time == Decimal.new("120.5")
      assert hacker_new.title == "some title"
      assert hacker_new.type == "some type"
      assert hacker_new.url == "some url"
    end

    test "create_hacker_new/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Story.create_hacker_new(@invalid_attrs)
    end

    test "update_hacker_new/2 with valid data updates the hacker_new" do
      hacker_new = hacker_new_fixture()
      assert {:ok, %HackerNew{} = hacker_new} = Story.update_hacker_new(hacker_new, @update_attrs)
      assert hacker_new.by == "some updated by"
      assert hacker_new.descendants == Decimal.new("456.7")
      assert hacker_new.kids == []
      assert hacker_new.score == Decimal.new("456.7")
      assert hacker_new.time == Decimal.new("456.7")
      assert hacker_new.title == "some updated title"
      assert hacker_new.type == "some updated type"
      assert hacker_new.url == "some updated url"
    end

    test "update_hacker_new/2 with invalid data returns error changeset" do
      hacker_new = hacker_new_fixture()
      assert {:error, %Ecto.Changeset{}} = Story.update_hacker_new(hacker_new, @invalid_attrs)
      assert hacker_new == Story.get_hacker_new!(hacker_new.id)
    end

    test "delete_hacker_new/1 deletes the hacker_new" do
      hacker_new = hacker_new_fixture()
      assert {:ok, %HackerNew{}} = Story.delete_hacker_new(hacker_new)
      assert_raise Ecto.NoResultsError, fn -> Story.get_hacker_new!(hacker_new.id) end
    end

    test "change_hacker_new/1 returns a hacker_new changeset" do
      hacker_new = hacker_new_fixture()
      assert %Ecto.Changeset{} = Story.change_hacker_new(hacker_new)
    end
  end
end
