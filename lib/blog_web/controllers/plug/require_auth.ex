defmodule BlogWeb.Plug.RequireAuth do
  use BlogWeb, :controller

  def init(_), do: nil

  def call(conn, _) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "Unauthorized: You need to be looged in to perform this action!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
