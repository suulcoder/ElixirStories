defmodule HackerNewsWeb.HackerNewView do
  use HackerNewsWeb, :view
  import Phoenix.Pagination.JSON
  alias HackerNewsWeb.HackerNewView

  def render("index.json", %{hackernews: hackernews}) do
    %{data: render_many(hackernews, HackerNewView, "hacker_new.json")}
  end

  def render("show.json", %{hacker_new: hacker_new}) do
    %{data: render_one(hacker_new, HackerNewView, "hacker_new.json")}
  end

  def render("pagination.json", %{products: products, pagination: pagination, conn: conn}) do
    %{data: render_many(products, HackerNewsWeb.HackerNewView, "hacker_new.json"),
      pagination: paginate(conn, pagination)}
  end

  def render("hacker_new.json", %{hacker_new: hacker_new}) do
    %{id: hacker_new.id,
      by: hacker_new.by,
      descendants: hacker_new.descendants,
      kids: hacker_new.kids,
      score: hacker_new.score,
      time: hacker_new.time,
      title: hacker_new.title,
      type: hacker_new.type,
      url: hacker_new.url}
  end
end
