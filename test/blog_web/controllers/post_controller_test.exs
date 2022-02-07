defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  @valid_post %{
    title: "Valid Post",
    description: "Lorem."
  }

  @update_post %{
    title: "Valid Post Updated",
    description: "Lorem updated."
  }

  def fixture(:post) do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    post
  end

  test "render form to create a new post", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :new))
    assert html_response(conn, 200) =~ "Create Post"
  end

  test "create a new post", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: @valid_post)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Valid Post"
  end

  test "create a new post with invalid data", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: %{})
    assert html_response(conn, 200) =~ "Field required"
  end

  describe "depends on the post created" do
    setup [:create_post]

    test "list all posts", %{conn: conn} do
      user = Blog.Accounts.get_user!(1)
      Blog.Posts.create_post(user, @valid_post)
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "Valid Post"
    end

    test "get a post by id", %{conn: conn, post: post} do
      user = Blog.Accounts.get_user!(1)
      Blog.Posts.create_post(user, @valid_post)
      conn = get(conn, Routes.post_path(conn, :show, post))
      assert html_response(conn, 200) =~ "Valid Post"
    end

    test "render form to edit post", %{conn: conn} do
      user = Blog.Accounts.get_user!(1)
      {:ok, post} = Blog.Posts.create_post(user, @valid_post)
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> get(Routes.post_path(conn, :edit, post))
      assert html_response(conn, 200) =~ "Edit Post"
    end

    test "update a post", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: @update_post)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

      conn = get(conn, Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Valid Post Updated"
    end

    test "update a post with invalid data", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: %{title: nil, description: nil})

      assert html_response(conn, 200) =~ "Edit Post"
    end

    test "delete a post", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> delete(Routes.post_path(conn, :delete, post))
      assert redirected_to(conn) == Routes.post_path(conn, :index)

      assert_error_sent 404, fn -> get(conn, Routes.post_path(conn, :show, post)) end
    end
  end

  defp create_post(_) do
    %{post: fixture(:post)}
  end
end
