defmodule HackerNews.Story.HackerNew do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hackernews" do
    field :by, :string
    field :descendants, :decimal
    field :kids, {:array, :decimal}
    field :score, :decimal
    field :time, :decimal
    field :title, :string
    field :type, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(hacker_new, attrs) do
    hacker_new
    |> cast(attrs, [:by, :descendants, :kids, :score, :time, :title, :type, :url])
    |> validate_required([:by, :descendants, :kids, :score, :time, :title, :type, :url])
  end
end
