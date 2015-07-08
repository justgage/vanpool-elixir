defmodule Vanpool.PageController do
  use Vanpool.Web, :controller

  alias Vanpool.Van

  def index(conn, _params) do
    user = Plug.Conn.get_session(conn, :current_user)
    token = Plug.Conn.get_session(conn, :access_token)
    vans = Repo.all(Van)
    render(conn, "index.html", user: user, vans: vans, token: token)
  end
end
