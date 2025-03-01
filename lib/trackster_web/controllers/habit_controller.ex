defmodule TracksterWeb.HabitController do
  use TracksterWeb, :controller

  alias Trackster.Habits
  alias Trackster.Habits.Habit

  # GET /api/habits
  def index(conn, _params) do
    habits = Habits.list_habits()
    json(conn, habits)
  end

  # GET /api/habits/:id
  def show(conn, %{"id" => id}) do
    case Habits.get_habit(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Habit not found"})
      habit ->
        json(conn, habit)
    end
  end

  # POST /api/habits
  # Expects parameters in the format: %{ "habit" => %{ "name" => "Exercise", "frequency" => "daily" } }
  def create(conn, %{"habit" => habit_params}) do
    case Habits.create_habit(habit_params) do
      {:ok, %Habit{} = habit} ->
        conn
        |> put_status(:created)
        |> json(habit)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: translate_errors(changeset)})
    end
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
