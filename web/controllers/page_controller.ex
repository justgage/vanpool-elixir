defmodule Vanpool.PageController do
  use Vanpool.Web, :controller

  alias Vanpool.Van

  def index(conn, _params) do
    vans = Repo.all(Van)
    render(conn, "index.html", vans: vans)
  end
end
