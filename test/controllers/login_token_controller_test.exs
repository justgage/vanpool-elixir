defmodule Vanpool.LoginTokenControllerTest do
  use Vanpool.ConnCase

  alias Vanpool.LoginToken
  @valid_attrs %{tokens: "some content", userId: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, login_token_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    login_token = Repo.insert! %LoginToken{}
    conn = get conn, login_token_path(conn, :show, login_token)
    assert json_response(conn, 200)["data"] == %{
      "id" => login_token.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, login_token_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, login_token_path(conn, :create), login_token: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(LoginToken, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, login_token_path(conn, :create), login_token: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    login_token = Repo.insert! %LoginToken{}
    conn = put conn, login_token_path(conn, :update, login_token), login_token: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(LoginToken, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    login_token = Repo.insert! %LoginToken{}
    conn = put conn, login_token_path(conn, :update, login_token), login_token: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    login_token = Repo.insert! %LoginToken{}
    conn = delete conn, login_token_path(conn, :delete, login_token)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(LoginToken, login_token.id)
  end
end
