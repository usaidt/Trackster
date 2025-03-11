defmodule Trackster.Repo.Migrations.CreateStreaks do
  use Ecto.Migration

  def change do
    create table(:streaks) do
      add :name, :string
      add :count, :integer
      add :last_updated_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:streaks, [:name])
  end
end
