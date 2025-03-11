defmodule TracksterWeb.HabitController do
  use TracksterWeb, :controller
  use TracksterWeb, :json_view

  alias Trackster.Habits
  alias Trackster.Habits.Habit


  def index(conn, _params) do
    habits = Habits.list_habits()
    render(conn, :index, habits: habits)
  end

  def show(conn, %{"id" => id}) do
    habit = Habits.get_habit!(id)
    render(conn, :show, habit: habit)
  end

  def create(conn, %{"habit" => habit_params}) do
    with {:ok, %Habit{} = habit} <- Habits.create_habit(habit_params) do
      conn
      |> put_status(:created)
      |> render(:show, habit: habit)
    end
  end

  def today(conn, %{"show_completed" => show_completed}) do
    habits = Habits.list_todays_habits(show_completed)
    render(conn, :index, habits: habits)
  end

  def today(conn, _params) do
    habits = Habits.list_todays_habits(false)
    render(conn, :index, habits: habits)
  end

  def complete(conn, %{"id" => id}) do
    habit = Habits.get_habit!(id)

    with {:ok, %Habit{} = updated_habit} <- Habits.mark_complete(habit) do
      render(conn, :show, habit: updated_habit)
    end
  end
end
