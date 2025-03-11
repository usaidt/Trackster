defmodule TracksterWeb.StreakController do
  use TracksterWeb, :controller
  alias Trackster.Streaks
  alias Trackster.Streaks.Streak

  def update(conn, %{"name" => name}) do
    case Streaks.get_or_create_streak(name) do
      {:ok, streak} ->
        render(conn, "show.json", streak: streak)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(TracksterWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"name" => name}) do
    case Streaks.delete_streak(name) do
      {:ok, _streak} ->
        send_resp(conn, :no_content, "")
      {:error, :not_found} ->
        send_resp(conn, :not_found, "Streak not found")
    end
  end

  def show(conn, %{"name" => name}) do
    case Streaks.get_streak_by_name(name) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Streak not found"})
      streak ->
        json(conn, %{name: streak.name, count: streak.count, last_updated_at: streak.last_updated_at})
    end
  end

  def reset(conn, %{"name" => name}) do
    case Streaks.reset_streak(name) do
      {:ok, %Streak{} = streak} ->
        json(conn, %{message: "Streak reset successfully", name: streak.name, count: streak.count})
      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Streak not found"})
      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Failed to reset streak", reason: reason})
    end
  end
end
