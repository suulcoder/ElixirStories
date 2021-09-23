defmodule HackerNewsWeb.HackerNewControllerTest do
  use HackerNewsWeb.ConnCase

  alias HackerNews.Story
  alias HackerNews.Story.HackerNew

  @create_attrs %{
    by: "some by",
    descendants: "120.5",
    kids: [],
    score: "120.5",
    time: "120.5",
    title: "some title",
    type: "some type",
    url: "some url"
  }
  @update_attrs %{
    by: "some updated by",
    descendants: "456.7",
    kids: [],
    score: "456.7",
    time: "456.7",
    title: "some updated title",
    type: "some updated type",
    url: "some updated url"
  }
  @invalid_attrs %{by: nil, descendants: nil, kids: nil, score: nil, time: nil, title: nil, type: nil, url: nil}

  def fixture(:hacker_new) do
    {:ok, hacker_new} = Story.create_hacker_new(@create_attrs)
    hacker_new
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all hackernews", %{conn: conn} do
      conn = get(conn, Routes.hacker_new_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create hacker_new" do
    test "renders hacker_new when data is valid", %{conn: conn} do
      conn = post(conn, Routes.hacker_new_path(conn, :create), hacker_new: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.hacker_new_path(conn, :show, id))

      assert %{
               "id" => id,
               "by" => "some by",
               "descendants" => "120.5",
               "kids" => [],
               "score" => "120.5",
               "time" => "120.5",
               "title" => "some title",
               "type" => "some type",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.hacker_new_path(conn, :create), hacker_new: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update hacker_new" do
    setup [:create_hacker_new]

    test "renders hacker_new when data is valid", %{conn: conn, hacker_new: %HackerNew{id: id} = hacker_new} do
      conn = put(conn, Routes.hacker_new_path(conn, :update, hacker_new), hacker_new: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.hacker_new_path(conn, :show, id))

      assert %{
               "id" => id,
               "by" => "some updated by",
               "descendants" => "456.7",
               "kids" => [],
               "score" => "456.7",
               "time" => "456.7",
               "title" => "some updated title",
               "type" => "some updated type",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, hacker_new: hacker_new} do
      conn = put(conn, Routes.hacker_new_path(conn, :update, hacker_new), hacker_new: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete hacker_new" do
    setup [:create_hacker_new]

    test "deletes chosen hacker_new", %{conn: conn, hacker_new: hacker_new} do
      conn = delete(conn, Routes.hacker_new_path(conn, :delete, hacker_new))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.hacker_new_path(conn, :show, hacker_new))
      end
    end
  end

  defp create_hacker_new(_) do
    hacker_new = fixture(:hacker_new)
    %{hacker_new: hacker_new}
  end
end
