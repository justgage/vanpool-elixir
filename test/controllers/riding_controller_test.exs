defmodule Vanpool.RidingControllerTest do
  use Vanpool.ConnCase

  alias Vanpool.Riding
  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, dir: "some content", time: %{hour: 14, min: 0}, userid: "some content", vanid: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, riding_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing riding"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, riding_path(conn, :new)
    assert html_response(conn, 200) =~ "New riding"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, riding_path(conn, :create), riding: @valid_attrs
    assert redirected_to(conn) == riding_path(conn, :index)
    assert Repo.get_by(Riding, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, riding_path(conn, :create), riding: @invalid_attrs
    assert html_response(conn, 200) =~ "New riding"
  end

  test "shows chosen resource", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = get conn, riding_path(conn, :show, riding)
    assert html_response(conn, 200) =~ "Show riding"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, riding_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = get conn, riding_path(conn, :edit, riding)
    assert html_response(conn, 200) =~ "Edit riding"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = put conn, riding_path(conn, :update, riding), riding: @valid_attrs
    assert redirected_to(conn) == riding_path(conn, :index)
    assert Repo.get_by(Riding, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = put conn, riding_path(conn, :update, riding), riding: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit riding"
  end

  test "deletes chosen resource", %{conn: conn} do
    riding = Repo.insert! %Riding{}
    conn = delete conn, riding_path(conn, :delete, riding)
    assert redirected_to(conn) == riding_path(conn, :index)
    refute Repo.get(Riding, riding.id)
  end
end
