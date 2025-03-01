defmodule Trackster.Habits.Habit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "habits" do
    field :name, :string
    field :frequency, :string
    field :created_date, :utc_datetime
    timestamps()
  end

  def changeset(habit, attrs) do
    habit
    |> cast(attrs, [:name, :frequency])
    |> validate_required([:name, :frequency])
  end
end
