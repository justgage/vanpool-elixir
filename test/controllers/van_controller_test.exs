defmodule Vanpool.VanControllerTest do
  use Vanpool.ConnCase

  alias Vanpool.Van
  @valid_attrs %{capacity: 42, come_time: "some content", description: "some content", go_time: "some content", number: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, van_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing vans"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, van_path(conn, :new)
    assert html_response(conn, 200) =~ "New van"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, van_path(conn, :create), van: @valid_attrs
    assert redirected_to(conn) == van_path(conn, :index)
    assert Repo.get_by(Van, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, van_path(conn, :create), van: @invalid_attrs
    assert html_response(conn, 200) =~ "New van"
  end

  test "shows chosen resource", %{conn: conn} do
    van = Repo.insert! %Van{}
    conn = get conn, van_path(conn, :show, van)
    assert html_response(conn, 200) =~ "Show van"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, van_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    van = Repo.insert! %Van{}
    conn = get conn, van_path(conn, :edit, van)
    assert html_response(conn, 200) =~ "Edit van"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    van = Repo.insert! %Van{}
    conn = put conn, van_path(conn, :update, van), van: @valid_attrs
    assert redirected_to(conn) == van_path(conn, :index)
    assert Repo.get_by(Van, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    van = Repo.insert! %Van{}
    conn = put conn, van_path(conn, :update, van), van: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit van"
  end

  test "deletes chosen resource", %{conn: conn} do
    van = Repo.insert! %Van{}
    conn = delete conn, van_path(conn, :delete, van)
    assert redirected_to(conn) == van_path(conn, :index)
    refute Repo.get(Van, van.id)
  end
end
