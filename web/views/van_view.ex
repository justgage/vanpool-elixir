defmodule Vanpool.VanView do
  alias Vanpool.Repo
  alias Vanpool.User
  alias Vanpool.Riding
  use Vanpool.Web, :view
  require Logger
  import Ecto.Query



  def riding_state(user_id, van) do
    Repo.all(Vanpool.Riding) 
    |> Enum.filter(fn(ride) -> ride.vanid == van.id end)
  end

  def riding_for_user(userid, date) do
    query = from r in Riding,
            where: r.userid == ^userid

    Repo.one(query)
  end

  def button_class(vanid, self_rider) do
    Logger.warn vanid
    Logger.warn self_rider.id
    if vanid == self_rider.vanid do
      "riding-state-" <> self_rider.dir
    else
      ""
    end
  end

  def van_driver?(vanid, date) do
    query = from r in Riding,
            where: r.keys == true

    query = from r in query,
            where: r.date == ^date

    length(Repo.all(query)) > 0
  end

  # gets the riders for a van
  # NOTE: returns them in a touple {user_info, rider_info}
  def get_riders(vanid, date) do

    query = from r in Riding,
            where: r.date == ^date

    query = from r in query,
            where: r.vanid == ^vanid

    query = from r in query,
            join: u in User, on: r.userid == u.userid,
            select: {u, r}

    Repo.all(query)
  end
end
