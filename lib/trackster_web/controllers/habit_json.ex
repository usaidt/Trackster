defmodule TracksterWeb.HabitJSON do
  alias Trackster.Habits.Habit

  def index(%{habits: habits}) do
    %{data: for(habit <- habits, do: data(habit))}
  end

  def show(%{habit: habit}) do
    %{data: data(habit)}
  end

  defp data(%Habit{} = habit) do
    %{
      id: habit.id,
      name: habit.name,
      description: habit.description,
      times_per_day: habit.times_per_day,
      completed_count: habit.completed_count,
      last_completed: habit.last_completed,
      inserted_at: habit.inserted_at
    }
  end
end
