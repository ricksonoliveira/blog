defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  def index(conn, params) do
    posts = [
      %{
        id: 1,
        title: "Phoenix"
      },
      %{
        id: 2,
        title: "Liveview"
      },
      %{
        id: 3,
        title: "Postgres"
      }
    ]

    render(conn, "index.html", posts: posts)
  end

  def show(conn, params) do
    render(conn, "show.html")
  end
end
