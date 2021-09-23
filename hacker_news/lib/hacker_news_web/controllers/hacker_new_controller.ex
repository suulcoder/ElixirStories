defmodule HackerNewsWeb.HackerNewController do
  use HackerNewsWeb, :controller

  alias HackerNews.Story
  alias HackerNews.Story.HackerNew

  action_fallback HackerNewsWeb.FallbackController

  def index(conn, _params) do
    hackernews = Story.list_hackernews()
    render(conn, "index.json", hackernews: hackernews)
  end

  def create(conn, %{"hacker_new" => hacker_new_params}) do
    with {:ok, %HackerNew{} = hacker_new} <- Story.create_hacker_new(hacker_new_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.hacker_new_path(conn, :show, hacker_new))
      |> render("show.json", hacker_new: hacker_new)
    end
  end

  def show(conn, %{"id" => id}) do
    hacker_new = Story.get_hacker_new!(id)
    render(conn, "show.json", hacker_new: hacker_new)
  end

  def update(conn, %{"id" => id, "hacker_new" => hacker_new_params}) do
    hacker_new = Story.get_hacker_new!(id)

    with {:ok, %HackerNew{} = hacker_new} <- Story.update_hacker_new(hacker_new, hacker_new_params) do
      render(conn, "show.json", hacker_new: hacker_new)
    end
  end

  def delete(conn, %{"id" => id}) do
    hacker_new = Story.get_hacker_new!(id)

    with {:ok, %HackerNew{}} <- Story.delete_hacker_new(hacker_new) do
      send_resp(conn, :no_content, "")
    end
  end
end
