defmodule Trackster.Habits.Habit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "habits" do
    field :name, :string
    field :description, :string
    field :times_per_day, :integer, default: 1
    field :completed_count, :integer, default: 0
    field :last_completed, :naive_datetime
    field :completed_at, :naive_datetime

    timestamps()
  end

  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:name, :description, :times_per_day])
    |> validate_required([:name, :times_per_day])
    |> validate_number(:times_per_day, greater_than: 0)
  end

  def completion_changeset(habit, attrs) do
    habit
    |> cast(attrs, [:last_completed])
    |> validate_required([])
    |> put_change(:completed_count, habit.completed_count + 1)
  end
end
