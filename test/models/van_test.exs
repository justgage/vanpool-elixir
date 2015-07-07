defmodule Vanpool.VanTest do
  use Vanpool.ModelCase

  alias Vanpool.Van

  @valid_attrs %{come: "some content", compacity: 42, go: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Van.changeset(%Van{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Van.changeset(%Van{}, @invalid_attrs)
    refute changeset.valid?
  end
end
