defmodule Vanpool.UserController do
  use Vanpool.Web, :controller

  alias Vanpool.User

  plug :scrub_params, "user" when action in [:create, :update]

  def index(_params) do
    users = Repo.all(User)
  end

  def create(%{"user" => user_params}) do

    %{"userid" => userid } = user_params

    ex_user = existing_user(userid)

    if ex_user do
      update(%{"id" => ex_user.id, "user" => user_params})
    else # create it

      changeset = User.changeset(%User{}, user_params)

      if changeset.valid? do
        user = Repo.insert!(changeset)
        :ok
      else
        :error
      end
    end
  end

  def show(%{"id" => id}) do
    user = Repo.get!(User, id)
  end

  def update(%{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      user = Repo.update!(changeset)
      :error
    else
      :ok
    end
  end

  def delete(%{"id" => id}) do
    user = Repo.get!(User, id)

    user = Repo.delete!(user)
  end

  def existing_user(userid) do
    import Ecto.Query

    query = from u in User,
          where: u.userid == ^userid

    Repo.all(query)
    |> List.first
  end
end
