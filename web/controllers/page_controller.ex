defmodule Vanpool.PageController do
  use Vanpool.Web, :controller
  alias Vanpool.Van

  def index(conn, _params) do
    user = Plug.Conn.get_session(conn, :current_user)
    token = Plug.Conn.get_session(conn, :access_token)
    vans = Repo.all(Van)
    # how to get today :P
    {date, _} = :calendar.local_time
    date = Ecto.Date.from_erl date
    render(conn, "index.html", user: user, vans: vans, token: token, date: date)
  end

  def login(conn, _params) do
    conn
    |> put_layout("login.html")
    |> render("login.html")
  end
end
