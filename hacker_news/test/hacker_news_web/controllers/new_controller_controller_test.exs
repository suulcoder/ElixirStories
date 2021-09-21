defmodule HackerNewsWeb.NewControllerControllerTest do
  use HackerNewsWeb.ConnCase

  alias HackerNews.New
  alias HackerNews.New.NewController

  @create_attrs %{
    by: "some by",
    descendants: "120.5",
    kids: [],
    score: "120.5",
    time: ~T[14:00:00],
    title: "some title",
    type: "some type",
    url: "some url"
  }
  @update_attrs %{
    by: "some updated by",
    descendants: "456.7",
    kids: [],
    score: "456.7",
    time: ~T[15:01:01],
    title: "some updated title",
    type: "some updated type",
    url: "some updated url"
  }
  @invalid_attrs %{by: nil, descendants: nil, kids: nil, score: nil, time: nil, title: nil, type: nil, url: nil}

  def fixture(:new_controller) do
    {:ok, new_controller} = New.create_new_controller(@create_attrs)
    new_controller
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all newcontrollers", %{conn: conn} do
      conn = get(conn, Routes.new_controller_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create new_controller" do
    test "renders new_controller when data is valid", %{conn: conn} do
      conn = post(conn, Routes.new_controller_path(conn, :create), new_controller: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.new_controller_path(conn, :show, id))

      assert %{
               "id" => id,
               "by" => "some by",
               "descendants" => "120.5",
               "kids" => [],
               "score" => "120.5",
               "time" => "14:00:00",
               "title" => "some title",
               "type" => "some type",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.new_controller_path(conn, :create), new_controller: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update new_controller" do
    setup [:create_new_controller]

    test "renders new_controller when data is valid", %{conn: conn, new_controller: %NewController{id: id} = new_controller} do
      conn = put(conn, Routes.new_controller_path(conn, :update, new_controller), new_controller: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.new_controller_path(conn, :show, id))

      assert %{
               "id" => id,
               "by" => "some updated by",
               "descendants" => "456.7",
               "kids" => [],
               "score" => "456.7",
               "time" => "15:01:01",
               "title" => "some updated title",
               "type" => "some updated type",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, new_controller: new_controller} do
      conn = put(conn, Routes.new_controller_path(conn, :update, new_controller), new_controller: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete new_controller" do
    setup [:create_new_controller]

    test "deletes chosen new_controller", %{conn: conn, new_controller: new_controller} do
      conn = delete(conn, Routes.new_controller_path(conn, :delete, new_controller))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.new_controller_path(conn, :show, new_controller))
      end
    end
  end

  defp create_new_controller(_) do
    new_controller = fixture(:new_controller)
    %{new_controller: new_controller}
  end
end
