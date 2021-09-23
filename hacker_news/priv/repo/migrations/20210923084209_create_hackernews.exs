defmodule HackerNews.Repo.Migrations.CreateHackernews do
  use Ecto.Migration

  def change do
    create table(:hackernews) do
      add :by, :string
      add :descendants, :decimal
      add :kids, {:array, :decimal}
      add :score, :decimal
      add :time, :decimal
      add :title, :text
      add :type, :string
      add :url, :string

      timestamps()
    end

  end
end
