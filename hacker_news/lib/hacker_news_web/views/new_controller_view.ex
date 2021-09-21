defmodule HackerNewsWeb.NewControllerView do
  use HackerNewsWeb, :view
  alias HackerNewsWeb.NewControllerView

  def render("index.json", %{newcontrollers: newcontrollers}) do
    %{data: render_many(newcontrollers, NewControllerView, "new_controller.json")}
  end

  def render("show.json", %{new_controller: new_controller}) do
    %{data: render_one(new_controller, NewControllerView, "new_controller.json")}
  end

  def render("new_controller.json", %{new_controller: new_controller}) do
    %{id: new_controller.id,
      by: new_controller.by,
      descendants: new_controller.descendants,
      kids: new_controller.kids,
      score: new_controller.score,
      time: new_controller.time,
      title: new_controller.title,
      type: new_controller.type,
      url: new_controller.url}
  end
end
