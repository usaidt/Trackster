defmodule Trackster.Streaks.Streak do
  use Ecto.Schema
  import Ecto.Changeset

  schema "streaks" do
    field :count, :integer
    field :name, :string
    field :last_updated_at, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(streak, attrs) do
    streak
    |> cast(attrs, [:name, :count, :last_updated_at])
    |> validate_required([:name, :count, :last_updated_at])
    |> unique_constraint(:name)
  end

  def reset_changeset(streak) do
    streak
    |> change(%{count: 0, last_updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)})
  end

end
