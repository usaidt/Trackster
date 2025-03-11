defmodule TracksterWeb.Router do
  use TracksterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TracksterWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TracksterWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  scope "/api", TracksterWeb do
    pipe_through :api

    # Streak endpoints
    get "/:name", StreakController, :show
    put "/:name", StreakController, :update
    patch "/:name/reset", StreakController, :reset
    delete "/:name", StreakController, :delete

    # Habit endpoints
    get "/habits/today", HabitController, :today, as: :today_habits
    resources "/habits", HabitController, only: [:index, :show, :create]
    patch "/habits/:id/complete", HabitController, :complete

    # Journal endpoints
    get "/journals/today", JournalController, :show_today
    put "/journals/today", JournalController, :update_today
    get "/journals/:date", JournalController, :show
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:trackster, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TracksterWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
