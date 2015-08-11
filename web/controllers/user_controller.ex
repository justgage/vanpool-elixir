defmodule Vanpool.UserController do
  use Vanpool.Web, :controller

  alias Vanpool.User

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

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
    if user == nil do
      pull_list()
      Repo.get!(User, id)
    else
      user
    end
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

  def pull_list() do
    SlackBot.start();
    token = SlackBot.get_token();
    user_list = SlackBot.get!("/users.list?token=" <> token).body;

    Enum.each(user_list, fn user -> 
      user_id = user["id"]
      slack_handle = user["name"]
      profile = user["profile"]

      name = profile["real_name"]
      avatar = profile["image_48"]
      email = profile["email"]
      phone = profile["phone"]

      create(%{"user" =>  %{
          "userid" => user_id,
          "avatar_url" => avatar,
          "real_name" => name,
          "slack_handle" => slack_handle,
          "phone" => phone,
          "email" => email,
      }})
    end)
  end

  def existing_user(userid) do
    import Ecto.Query

    query = from u in User,
          where: u.userid == ^userid

    Repo.all(query)
    |> List.first
  end
end
