defmodule HackerNewsWeb.PageController do
  use HackerNewsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
