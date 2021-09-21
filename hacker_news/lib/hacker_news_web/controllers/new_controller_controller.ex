defmodule HackerNewsWeb.NewControllerController do
  use HackerNewsWeb, :controller

  alias HackerNews.New
  alias HackerNews.New.NewController

  action_fallback HackerNewsWeb.FallbackController

  def index(conn, _params) do
    newcontrollers = New.list_newcontrollers()
    render(conn, "index.json", newcontrollers: newcontrollers)
  end

  def create(conn, %{"new_controller" => new_controller_params}) do
    with {:ok, %NewController{} = new_controller} <- New.create_new_controller(new_controller_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.new_controller_path(conn, :show, new_controller))
      |> render("show.json", new_controller: new_controller)
    end
  end

  def show(conn, %{"id" => id}) do
    new_controller = New.get_new_controller!(id)
    render(conn, "show.json", new_controller: new_controller)
  end

  def update(conn, %{"id" => id, "new_controller" => new_controller_params}) do
    new_controller = New.get_new_controller!(id)

    with {:ok, %NewController{} = new_controller} <- New.update_new_controller(new_controller, new_controller_params) do
      render(conn, "show.json", new_controller: new_controller)
    end
  end

  def delete(conn, %{"id" => id}) do
    new_controller = New.get_new_controller!(id)

    with {:ok, %NewController{}} <- New.delete_new_controller(new_controller) do
      send_resp(conn, :no_content, "")
    end
  end
end
