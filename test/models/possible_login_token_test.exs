defmodule Vanpool.PossibleLoginTokenTest do
  use Vanpool.ModelCase

  alias Vanpool.PossibleLoginToken

  @valid_attrs %{tokens: "some content", userId: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PossibleLoginToken.changeset(%PossibleLoginToken{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PossibleLoginToken.changeset(%PossibleLoginToken{}, @invalid_attrs)
    refute changeset.valid?
  end
end
