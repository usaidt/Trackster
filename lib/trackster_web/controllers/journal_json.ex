defmodule TracksterWeb.JournalJSON do

  def show(%{journal: journal}) do
    %{
      data: %{
        id: journal.id,
        entry_date: journal.entry_date,
        content: journal.content,
        inserted_at: journal.inserted_at
      }
    }
  end
end
