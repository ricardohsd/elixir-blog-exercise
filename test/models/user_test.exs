defmodule Pxblog.UserTest do
  use Pxblog.ModelCase

  alias Pxblog.User
  alias Pxblog.TestHelper

  @valid_attrs %{email: "some content", password: "some content",
    password_confirmation: "some content", username: "some content"}
  @invalid_attrs %{}

  setup do
    {:ok, role} = TestHelper.create_role(%{name: "user", admin: false})
    {:ok, role: role}
  end

  test "changeset with valid attributes", %{role: role} do
    changeset = User.changeset(%User{}, valid_attrs(role))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password_digest value gets set to a hash", %{role: role} do
    changeset = User.changeset(%User{}, valid_attrs(role))
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password,
      Ecto.Changeset.get_change(changeset, :password_digest))
  end

  test "password_digest value does not get set if password is nil", %{role: role} do
    changeset = User.changeset(%User{}, %{email: "test@test.com",
      password: nil, password_confirmation: nil, username: "test", role_id: role.id})

    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end

  defp valid_attrs(role) do
    Map.put(@valid_attrs, :role_id, role.id)
  end
end
