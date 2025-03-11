defmodule Trackster.Repo.Migrations.CreateJournals do
  use Ecto.Migration

  def change do
    create table(:journals) do
      add :entry_date, :date, null: false
      add :content, :text
      timestamps()
    end

    create unique_index(:journals, [:entry_date])
  end
end
