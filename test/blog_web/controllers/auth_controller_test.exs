defmodule BlogWeb.AuthControllerTest do
  use BlogWeb.ConnCase

  @ueberauth %Ueberauth.Auth{
    credentials: %{
      token: "123"
    },
    info: %{
      email: "test@test.com",
      first_name: "Rick",
      last_name: "Oliveira",
      image: "image.com/fake-image",
    },
    provider: "google"
  }

  test "callback success", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth)
      |> get(Routes.auth_path(conn, :callback, "google"))

      assert redirected_to(conn) == Routes.page_path(conn, :index)
      conn = get(conn, Routes.page_path(conn, :index))
      assert html_response(conn, 200) =~ "Welcome #{@ueberauth.info.email} !"
  end
end
