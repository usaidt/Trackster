defmodule Trackster.Habits do
  import Ecto.Query, warn: false
  alias Trackster.Repo
  alias Trackster.Habits.Habit

  def get_habit(id) do
    Repo.get(Habit, id)
  end

  def create_habit(habit_params) do
    %Habit{}
    |> Habit.changeset(habit_params)
    |> Repo.insert()
  end

  def list_habits do
    Repo.all(Habit)
  end
end
