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

  def riding_for_user(nil, date), do: nil
  def riding_for_user(userid, date) do
    query = from r in Riding,
    where: r.date== ^date,
    where: r.userid == ^userid

    Repo.all(query)
  end

  def van_has_rider(van, self_rider) do
      self_rider != nil && 
      Enum.find(self_rider, fn s -> s.vanid == van.id end) 
  end

  def van_status_class(vanid, date) do
    driver = van_driver?(vanid, date)

    if driver do
      "is-good"
    else
      "is-critical"
    end
  end

  def riding?(userid, vanid, date) do
    query = from r in Riding,
    where: r.date == ^date,
    where: r.vanid == ^vanid,
    where: r.userid == ^userid

    length(Repo.all(query)) > 0
  end

  def van_driver?(vanid, date) do
    in_drivers = from r in Riding,
    where: r.dir == "in",
    where: r.keys == true,
    where: r.date == ^date,
    where: r.vanid == ^vanid

    out_drivers = from r in Riding,
    where: r.dir == "out",
    where: r.keys == true,
    where: r.date == ^date,
    where: r.vanid == ^vanid

    in? = length(Repo.all(in_drivers)) > 0
    out? = length(Repo.all(out_drivers)) > 0

    in? && out?
  end

  # gets the riders for a van
  # NOTE: returns them in a touple {user_info, rider_info}
  def get_riders(vanid, date) do

    query = from r in Riding,
    where: r.date == ^date and r.vanid == ^vanid,
    join: u in User, on: r.userid == u.userid,
    select: {u, r}

    riders = Repo.all(query)

    riders 
    |> Enum.sort_by( fn {u,r} -> !r.keys end )
    |> Enum.sort_by( fn {u,r} -> r.dir end )
  end

end
