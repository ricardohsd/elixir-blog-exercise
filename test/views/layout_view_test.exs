defmodule Pxblog.LayoutViewTest do
  use Pxblog.ConnCase
  alias Pxblog.LayoutView
  alias Pxblog.TestHelper

  @valid_attributes %{username: "test2", password: "test2",
    password_confirmation: "test2", email: "test@test.com"}

  setup do
    {:ok, role} = TestHelper.create_role(%{name: "User Role", admin: false})
    {:ok, user} = TestHelper.create_user(role, @valid_attributes)

    conn = conn()
    {:ok, conn: conn, user: user}
  end

  test "current user returns user in the session", %{conn: conn, user: user} do
    conn = post conn, session_path(conn, :create), user: %{username: user.username,
      password: user.password}
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{user: user} do
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end
