defmodule Vanpool.RidingControllerTest do
  use Vanpool.ConnCase

  alias Vanpool.Riding
  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, dir: "some content", keys: true, userid: "some content", vanid: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, riding_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = get conn, riding_path(conn, :show, riding)
    assert json_response(conn, 200)["data"] == %{
      "id" => riding.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, riding_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, riding_path(conn, :create), riding: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Riding, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, riding_path(conn, :create), riding: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = put conn, riding_path(conn, :update, riding), riding: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Riding, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = put conn, riding_path(conn, :update, riding), riding: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = delete conn, riding_path(conn, :delete, riding)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Riding, riding.id)
  end
end
