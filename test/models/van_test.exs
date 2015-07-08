defmodule Vanpool.VanTest do
  use Vanpool.ModelCase

  alias Vanpool.Van

  @valid_attrs %{capacity: 42, come_time: "some content", description: "some content", go_time: "some content", number: 42}
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
