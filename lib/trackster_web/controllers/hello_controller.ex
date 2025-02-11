defmodule TracksterWeb.HelloController do
  use TracksterWeb, :controller

  def index(conn, _params) do
    json(conn, %{message: "Hello, World!"})
  end

  def hello(conn, %{"name" => name}) do
    json(conn, %{message: "Hello, #{name}!"})
  end
end
