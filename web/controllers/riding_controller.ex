defmodule Vanpool.RidingController do
  require Logger
  use Vanpool.Web, :controller

  alias Vanpool.Riding

  plug :scrub_params, "riding" when action in [:create, :update]

  def index(conn, _params) do
    riding = Repo.all(Riding)
    render(conn, "index.json", riding: riding)
  end

  defp self_rider(userid, date) do
    import Ecto.Query

    query = from r in Riding,
          where: r.userid == ^userid

    query = from r in query,
          where: r.date == ^date

    Repo.all(query)
    |> List.first
  end

  def create(conn, %{"riding" => riding_params}) do

    me = self_rider(riding_params["userid"], riding_params["date"])

    if me != nil do # already registered
      update(conn, %{"id" => me.id, "riding" => riding_params})
    else # not registered yet
      changeset = Riding.changeset(%Riding{}, riding_params)

      if changeset.valid? do
        riding = Repo.insert!(changeset)
        render(conn, "show.json", riding: riding)
      else
        conn
        |> put_status(:unprocessable_entity)
        |> render(Vanpool.ChangesetView, "error.json", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    riding = Repo.get!(Riding, id)
    render conn, "show.json", riding: riding
  end

  def update(conn, %{"id" => id, "riding" => riding_params}) do
    riding = Repo.get!(Riding, id)
    changeset = Riding.changeset(riding, riding_params)

    if changeset.valid? do
      riding = Repo.update!(changeset)
      render(conn, "show.json", riding: riding)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Vanpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    riding = Repo.get!(Riding, id)
    riding = Repo.delete!(riding)
    render(conn, "show.json", riding: riding)
  end
end
