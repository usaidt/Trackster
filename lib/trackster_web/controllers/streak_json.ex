defmodule TracksterWeb.StreakJSON do

  def show(%{streak: streak}) do
    %{
      data: %{
        name: streak.name,
        count: streak.count,
        last_updated_at: streak.last_updated_at
      }
    }
  end
end
