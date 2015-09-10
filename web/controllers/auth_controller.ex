defmodule Vanpool.AuthController do
  require Logger
  use Vanpool.Web, :controller

  @doc """
  This action is reached via `/auth` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, _params) do
    redirect conn, external: SlackOAuth2.authorize_url!
  end

  @doc """
  OLD OAUTH stuff!
  """
  def callback(conn, %{"code" => code}) do
    # tokenstuff = OAuth2.AccessToken.get!(token, ("/auth.test?token=" <> token))
    # %{"user" => user_name, "user_id" => user_id} = tokenstuff
    # %{"user" => user} = OAuth2.AccessToken.get!(token, ("/users.info?token=#{token}&user=#{user_id}"))
    #
    # profile = user["profile"]
    #
    # name = profile["real_name"]
    # avatar = profile["image_48"]
    # email = profile["email"]
    # phone = profile["phone"]
    #
    # Vanpool.UserController.create(%{"user" =>  %{
    #     "userid" => user_id,
    #     "avatar_url" => avatar,
    #     "real_name" => name,
    #     "slack_handle" => user_name,
    #     "phone" => phone,
    #     "email" => email,
    #   } 
    # })
    #
    conn
    # |> put_session(:user_id, user_id)
    # |> put_session(:current_user, user_name)
    # |> put_session(:access_token, token.access_token)
    # |> put_session(:token, token)
    # |> put_session(:user_real_name, name)
    # |> put_session(:user_avatar, avatar)
    |> redirect(to: "/")
  end

  def logout(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> put_session(:current_user, nil)
    |> put_session(:access_token, nil)
    |> put_session(:token, nil)
    |> put_session(:user_real_name, nil)
    |> put_session(:user_avatar, nil)
    |> redirect(to: "/")
  end

  def relogin_username do

  end
end

