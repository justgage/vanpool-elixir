defmodule Vanpool.RidingTest do
  use Vanpool.ModelCase

  alias Vanpool.Riding

  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, dir: "some content", keys: true, userid: "some content", vanid: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Riding.changeset(%Riding{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Riding.changeset(%Riding{}, @invalid_attrs)
    refute changeset.valid?
  end
end
