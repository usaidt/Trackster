defmodule TracksterWeb.FallbackController do
  use TracksterWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: TracksterWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: TracksterWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :max_completions_reached}) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Maximum completions reached for today"})
  end

  def call(conn, {:error, :invalid_date}) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Invalid date format"})
  end
end
