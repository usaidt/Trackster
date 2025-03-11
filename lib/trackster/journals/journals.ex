defmodule Trackster.Journals do
  import Ecto.Query, warn: false
  alias Trackster.Repo
  alias Trackster.Journals.Journal

  def get_todays_entry! do
    today = NaiveDateTime.utc_now() |> NaiveDateTime.to_date()
    case Repo.get_by(Journal, entry_date: today) do
      nil -> %Journal{entry_date: today, content: ""}
      journal -> journal
    end
  end

  def update_todays_entry(content) do
    today = NaiveDateTime.utc_now() |> NaiveDateTime.to_date()

    case Repo.get_by(Journal, entry_date: today) do
      nil ->
        %Journal{entry_date: today, content: content}
        |> Repo.insert()
      journal ->
        journal
        |> Journal.changeset(%{content: content})
        |> Repo.update()
    end
  end

  def get_by_date!(date) do
    case Repo.get_by(Journal, entry_date: date) do
      nil -> %Journal{entry_date: date, content: ""}
      journal -> journal
    end
  end
end
