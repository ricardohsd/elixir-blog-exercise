defmodule Pxblog.LayoutViewTest do
  use Pxblog.ConnCase, async: true
  alias Pxblog.LayoutView
  alias Pxblog.User

  @valid_attributes %{username: "test2", password: "test2",
    password_confirmation: "test2", email: "test@test.com"}

  setup do
    case Repo.one(User, username: @valid_attributes[:username]) do
      nil ->
        User.changeset(%User{}, @valid_attributes)
        |> Repo.insert
      _ ->
    end

    conn = conn()
    {:ok, conn: conn}
  end

  test "current user returns user in the session", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: %{username: "test2",
      password: "test2"}
    assert LayoutView.current_user(conn)
  end

  test "current user returns nothing if there is no user in the session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "test2"})
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end
