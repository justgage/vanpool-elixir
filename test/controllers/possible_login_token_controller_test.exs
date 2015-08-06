defmodule Vanpool.PossibleLoginTokenControllerTest do
  use Vanpool.ConnCase

  alias Vanpool.PossibleLoginToken
  @valid_attrs %{tokens: "some content", userId: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, possible_login_token_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing possibleLoginTokens"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, possible_login_token_path(conn, :new)
    assert html_response(conn, 200) =~ "New possible_login_token"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, possible_login_token_path(conn, :create), possible_login_token: @valid_attrs
    assert redirected_to(conn) == possible_login_token_path(conn, :index)
    assert Repo.get_by(PossibleLoginToken, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, possible_login_token_path(conn, :create), possible_login_token: @invalid_attrs
    assert html_response(conn, 200) =~ "New possible_login_token"
  end

  test "shows chosen resource", %{conn: conn} do
    possible_login_token = Repo.insert! %PossibleLoginToken{}
    conn = get conn, possible_login_token_path(conn, :show, possible_login_token)
    assert html_response(conn, 200) =~ "Show possible_login_token"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, possible_login_token_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    possible_login_token = Repo.insert! %PossibleLoginToken{}
    conn = get conn, possible_login_token_path(conn, :edit, possible_login_token)
    assert html_response(conn, 200) =~ "Edit possible_login_token"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    possible_login_token = Repo.insert! %PossibleLoginToken{}
    conn = put conn, possible_login_token_path(conn, :update, possible_login_token), possible_login_token: @valid_attrs
    assert redirected_to(conn) == possible_login_token_path(conn, :index)
    assert Repo.get_by(PossibleLoginToken, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    possible_login_token = Repo.insert! %PossibleLoginToken{}
    conn = put conn, possible_login_token_path(conn, :update, possible_login_token), possible_login_token: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit possible_login_token"
  end

  test "deletes chosen resource", %{conn: conn} do
    possible_login_token = Repo.insert! %PossibleLoginToken{}
    conn = delete conn, possible_login_token_path(conn, :delete, possible_login_token)
    assert redirected_to(conn) == possible_login_token_path(conn, :index)
    refute Repo.get(PossibleLoginToken, possible_login_token.id)
  end
end
