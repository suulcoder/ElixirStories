defmodule HackerNews.Repo.Migrations.CreateNewcontrollers do
  use Ecto.Migration

  def change do
    create table(:newcontrollers) do
      add :by, :string
      add :descendants, :decimal
      add :kids, {:array, :decimal}
      add :score, :decimal
      add :time, :time
      add :title, :text
      add :type, :string
      add :url, :string

      timestamps()
    end

  end
end
