defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  def index(conn, params) do
    posts = [
      %{
        title: "Phoenix"
      },
      %{
        title: "Liveview"
      },
      %{
        title: "Postgres"
      }
    ]

    render(conn, "index.html", posts: posts)
  end
end
