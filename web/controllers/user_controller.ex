defmodule Vanpool.UserController do
  use Vanpool.Web, :controller

  alias Vanpool.User

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do

    %{"userid" => userid } = user_params

    ex_user = existing_user(userid)

    if ex_user do
      update(conn, %{"id" => ex_user.id, "user" => user_params})
    else # create it

      changeset = User.changeset(%User{}, user_params)

      if changeset.valid? do
        user = Repo.insert!(changeset)
        # render(conn, "show.json", user: user)
      else
        # conn
        # |> put_status(:unprocessable_entity)
        # |> render(Vanpool.ChangesetView, "error.json", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render conn, "show.json", user: user
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      user = Repo.update!(changeset)
      # render(conn, "show.json", user: user)
    else
      # conn
      # |> put_status(:unprocessable_entity)
      # |> render(Vanpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    user = Repo.delete!(user)
    render(conn, "show.json", user: user)
  end

  def existing_user(userid) do
    import Ecto.Query

    query = from u in User,
          where: u.userid == ^userid

    Repo.all(query)
    |> List.first
  end
end
