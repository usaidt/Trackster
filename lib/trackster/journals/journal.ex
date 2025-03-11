defmodule Trackster.Journals.Journal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "journals" do
    field :entry_date, :date
    field :content, :string
    timestamps()
  end

  def changeset(journal, attrs) do
    journal
    |> cast(attrs, [:content, :entry_date])
    |> validate_required([:entry_date])
    |> unique_constraint(:entry_date)
  end
end
