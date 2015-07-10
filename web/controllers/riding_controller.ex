defmodule Vanpool.RidingController do
  require Logger
  use Vanpool.Web, :controller

  alias Vanpool.Riding

  plug :scrub_params, "riding" when action in [:create, :update]

  def index(conn, _params) do
    riding = Repo.all(Riding)
    render(conn, "index.json", riding: riding)
  end

  defp self_riders("round", userid, date) do
    import Ecto.Query

    query = from r in Riding,
          where: r.userid == ^userid,
          where: r.date == ^date

    Repo.all(query)
  end
  defp self_riders(dir, userid, date) do
    import Ecto.Query

    query = from r in Riding,
      where: r.userid == ^userid,
      where: r.dir == ^dir or r.dir == "round",
      where: r.date == ^date

    Repo.all(query)
  end

  def should_update(nil, _riding_params), do: true
  def should_update(rider, riding_params) do
    true
  end

  def create(conn, %{"riding" => riding_params}) do
    case riding_params["dir"] do
      "round" ->
        create_one(conn, %{"riding" => Map.put(riding_params, "dir", "in")})
        create_one(conn, %{"riding" => Map.put(riding_params, "dir", "out")})
      x ->
      create_one(conn, %{"riding" => riding_params})
    end
  end

  defp create_one(conn, %{"riding" => riding_params}) do
    # delete the other ridings to replace them
    # so that round trips will replace the two individal ones
    # and the two indivdual (in and out) will
    # not mess with eachother
    self_riders(riding_params["dir"], riding_params["userid"], riding_params["date"])

    |> Enum.each(fn self_rider ->
        delete(conn, %{
          "id" => self_rider.id,
          "riding" => riding_params
        }) 
      end)

    dir = riding_params["dir"]
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
