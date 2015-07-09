defmodule Vanpool.UserTest do
  use Vanpool.ModelCase

  alias Vanpool.User

  @valid_attrs %{avatar_url: "some content", email: "some content", phone: "some content", real_name: "some content", slack_handle: "some content", userid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
