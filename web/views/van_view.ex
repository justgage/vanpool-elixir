defmodule Vanpool.VanView do
  alias Vanpool.Repo
  alias Vanpool.User
  alias Vanpool.Riding
  use Vanpool.Web, :view
  require Logger



  def riding_state(user_id, van) do
    Repo.all(Vanpool.Riding) 
    |> Enum.filter(fn(ride) -> ride.vanid == van.id end)
  end

  def get_riders(vanid, date) do
    import Ecto.Query

    query = from r in Riding,
            where: r.date == ^date

    query = from r in query,
            where: r.vanid == ^vanid

    query = from r in query,
            join: u in User, on: r.userid == u.userid,
            select: {u, r}

    # riders = Repo.all(Vanpool.Riding) 
    #           |> Enum.filter(fn(ride) -> ride.vanid == van.id end)
    #           |> Enum.filter(fn(ride) -> ride.date == date end)
    #           |> Enum.group_by(&(&1.userid))
    #
    #
    # Enum.filter(users, fn(user) -> riders[user.userid] end)

    Repo.all(query)
  end
end
