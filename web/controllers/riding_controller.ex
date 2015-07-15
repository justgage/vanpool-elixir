defmodule Vanpool.RidingController do
  require Logger
  use Vanpool.Web, :controller

  alias Vanpool.Riding

  plug :scrub_params, "riding" when action in [:create, :update]

  def index(conn, _params) do
    riding = Repo.all(Riding)
    render(conn, "index.json", riding: riding)
  end

  defp self_riders_van(dir, userid, date, vanid) do
    self_riders(dir, userid, date)
    |> Enum.filter(fn riders -> riders.vanid == vanid end)
  end

  defp self_riders("round", userid, date) do
    import Ecto.Query

    query = from r in Riding,
          where: r.date == ^date,
          where: r.userid == ^userid

    Repo.all(query)
  end
  defp self_riders(dir, userid, date) do
    import Ecto.Query

    query = from r in Riding,
      where: r.date == ^date,
      where: r.userid == ^userid,
      where: r.dir == ^dir or r.dir == "round"

    Repo.all(query)
  end

  def create(conn, %{"riding" => riding_params}) do
    # grab all 'ridings' going on the same van
    Logger.warn("Turning on")
    case riding_params["dir"] do
      "round" ->
        create_one(conn, %{"riding" => Map.put(riding_params, "dir", "in")})
        create_one(conn, %{"riding" => Map.put(riding_params, "dir", "out")})
      _ ->
        create_one(conn, %{"riding" => riding_params})
    end
  end


  # Should I create them? 
  # You should when it does not equal exactly the same state
  # as we currently have
  defp exact_same_button(sr, "round") do
    in? = Enum.find(sr, fn s -> 
      Logger.warn "#{s.dir} == in (round)"
      s.dir == "in" end) != nil 
    out? = Enum.find(sr, fn s -> 
      Logger.warn "#{s.dir} == out (round)"
      s.dir == "out" end) != nil 

      Logger.warn "in? #{in?} && out #{out?} == #{in? && out?}"
      in? && out?
  end
  defp exact_same_button(sr, "in") do
    in? = Enum.find(sr, fn s -> 
      Logger.warn "#{s.dir} == in (in)"
      s.dir == "in" end) != nil 
    out? = Enum.find(sr, fn s -> 
      Logger.warn "#{s.dir} == out (in)"
      s.dir == "out" end) == nil 

      Logger.warn "in? #{in?} && out #{out?} == #{in? && out?}"
      in? && out? 
  end
  defp exact_same_button(sr, "out") do
    in? = Enum.find(sr, fn s -> 
      Logger.warn "#{s.dir} == in (out)"
      s.dir == "in" end) == nil 
    out? = Enum.find(sr, fn s -> 
      Logger.warn "#{s.dir} == out (out)"
      s.dir == "out" end) != nil 

      Logger.warn "in? #{in?} && out #{out?} == #{in? && out?}"
      in? && out?
  end

  defp create_one(conn, %{"riding" => riding_params}) do
    # delete the other ridings to replace them
    # so that round trips will replace the two individal ones
    # and the two indivdual (in and out) will
    # not mess with eachother
    sr = self_riders(riding_params["dir"], riding_params["userid"], riding_params["date"])
    Enum.each(sr, fn self_rider -> delete(conn, %{ "id" => self_rider.id, }) end)

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
    riding
  end

  def delete_all(conn, %{"riding" => riding_params}) do
    sr = self_riders("round", riding_params["userid"], riding_params["date"])
    Enum.each(sr, fn self_rider -> delete(conn, %{ "id" => self_rider.id, }) end)
    render(conn, "show.json", riding: nil)
  end
end
