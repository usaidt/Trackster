defmodule Trackster.Streaks do
  import Ecto.Query, warn: false
  alias Trackster.Repo
  alias Trackster.Streaks.Streak

  def get_or_create_streak(name) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    case Repo.get_by(Streak, name: name) do
      nil ->
        %Streak{name: name, count: 1, last_updated_at: now}
        |> Repo.insert()
      %Streak{} = streak ->
        update_streak(streak, now)
    end
  end

  defp update_streak(%Streak{last_updated_at: last_updated_at} = streak, now) do
    if NaiveDateTime.diff(now, last_updated_at, :second) > 86_400 do
      streak
      |> Streak.changeset(%{count: 1, last_updated_at: now})
      |> Repo.update()
    else
      streak
      |> Streak.changeset(%{count: streak.count + 1, last_updated_at: now})
      |> Repo.update()
    end
  end

  def get_streak_by_name(name) do
    Repo.get_by(Streak, name: name)
  end

  def reset_streak(name) do
    case get_streak_by_name(name) do
      nil ->
        {:error, :not_found}
      %Streak{} = streak ->
        streak
        |> Streak.reset_changeset()
        |> Repo.update()
    end
  end

  def delete_streak(name) do
    case Repo.get_by(Streak, name: name) do
      nil -> {:error, :not_found}
      %Streak{} = streak -> Repo.delete(streak)
    end
  end
end
