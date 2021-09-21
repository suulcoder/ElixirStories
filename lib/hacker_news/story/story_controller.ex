defmodule HackerNews.Story.StoryController do
  use Ecto.Schema
  import Ecto.Changeset

  schema "storycontrollers" do
    field :by, :string
    field :descendants, :decimal
    field :kids, {:array, :decimal}
    field :score, :decimal
    field :time, :time
    field :title, :string
    field :type, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(story_controller, attrs) do
    story_controller
    |> cast(attrs, [:by, :descendants, :kids, :score, :time, :title, :type, :url])
    |> validate_required([:by, :descendants, :kids, :score, :time, :title, :type, :url])
  end
end
