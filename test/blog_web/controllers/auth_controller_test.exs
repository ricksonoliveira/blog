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
      image: "image.com/fake-image"
    },
    provider: "google"
  }

  @ueberauth_error %Ueberauth.Auth{
    credentials: %{
      token: nil
    },
    info: %{
      email: "test@test.com",
      first_name: nil,
      last_name: nil,
      image: nil
    },
    provider: nil
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

  test "callback request", %{conn: conn} do
    conn =
      conn
      |> get(Routes.auth_path(conn, :request, "google"))

    assert redirected_to(conn) =~ "accounts.google.com"
  end

  test "callback error", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_error)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Hmmm... something went wrong."
  end

  test "logout success", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 2)
      |> get(Routes.auth_path(conn, :logout))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
  end
end
