defmodule Trackster.Habits do
  import Ecto.Query, warn: false
  alias Trackster.Repo

  alias Trackster.Habits.Habit
  def list_habits do
    Repo.all(Habit)
  end

  def get_habit!(id), do: Repo.get!(Habit, id)

  def create_habit(attrs \\ %{}) do
    %Habit{}
    |> Habit.changeset(attrs)
    |> Repo.insert()
  end

  def list_todays_habits(show_completed) do
    today = Date.utc_today()
    {:ok, start_of_day} = NaiveDateTime.new(today, ~T[00:00:00])
    {:ok, end_of_day} = NaiveDateTime.new(today, ~T[23:59:59])

    start_of_day = NaiveDateTime.truncate(start_of_day, :second)
    end_of_day = NaiveDateTime.truncate(end_of_day, :second)

    query = from h in Habit,
      where: h.inserted_at >= ^start_of_day and h.inserted_at <= ^end_of_day,
      order_by: [desc: h.inserted_at]

    query = if show_completed do
      query
    else
      from h in query,
        where: h.completed_count < h.times_per_day
    end

    Repo.all(query)
  end

  def mark_complete(habit) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    habit
    |> Habit.completion_changeset(%{last_completed: now})
    |> Repo.update()
  end
end
