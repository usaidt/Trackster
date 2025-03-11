defmodule TracksterWeb.JournalController do
  use TracksterWeb, :controller
  use TracksterWeb, :json_view

  alias Trackster.Journals
  alias Trackster.Journals.Journal

  def show_today(conn, _params) do
    journal = Journals.get_todays_entry!() |> NaiveDateTime.truncate(:second)
    render(conn, :show, journal: journal)
  end

  def update_today(conn, %{"content" => content}) do
    with {:ok, %Journal{} = journal} <- Journals.update_todays_entry(content |> NaiveDateTime.truncate(:second)) do
      render(conn, :show, journal: journal)
    end
  end

  def show(conn, %{"date" => date}) do
    case Date.from_iso8601(date) do
      {:ok, date} ->
        journal = Journals.get_by_date!(date |> NaiveDateTime.truncate(:second))
        render(conn, :show, journal: journal)
      _error ->
        send_resp(conn, :bad_request, "Invalid date format")
    end
  end
end
