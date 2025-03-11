defmodule Trackster.Repo.Migrations.CreateHabits do
  use Ecto.Migration

  def change do
    create table(:habits) do
      add :name, :string, null: false
      add :description, :text
      add :times_per_day, :integer, null: false, default: 1
      add :completed_count, :integer, default: 0
      add :last_completed, :naive_datetime
      add :completed_at, :naive_datetime
      timestamps()
    end

    create index(:habits, [:name])
  end
end
