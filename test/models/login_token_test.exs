defmodule Vanpool.LoginTokenTest do
  use Vanpool.ModelCase

  alias Vanpool.LoginToken

  @valid_attrs %{tokens: "some content", userId: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LoginToken.changeset(%LoginToken{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LoginToken.changeset(%LoginToken{}, @invalid_attrs)
    refute changeset.valid?
  end
end
