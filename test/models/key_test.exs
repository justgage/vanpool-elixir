defmodule Vanpool.KeyTest do
  use Vanpool.ModelCase

  alias Vanpool.Key

  @valid_attrs %{userid: "some content", vanid: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Key.changeset(%Key{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Key.changeset(%Key{}, @invalid_attrs)
    refute changeset.valid?
  end
end
