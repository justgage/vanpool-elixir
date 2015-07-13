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
  This action is reached via `/auth/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do
    # Exchange an auth code for an access token
    token = SlackOAuth2.get_token!(code: code)
    # Request the user's data with the access token
    tokenstuff = OAuth2.AccessToken.get!(token, ("/auth.test?token=" <> token.access_token))
    %{"user" => user_name, "user_id" => user_id} = tokenstuff
    # Store the user in the session under `:current_user` and redirect to /.
    # In most cases, we'd probably just store the user's ID that can be used
    # to fetch from the database. In this case, since this example app has no
    # database, I'm just storing the user map.
    #
    # If you need to make additional resource requests, you may want to store
    # the access token as well.

    %{"user" => user} = OAuth2.AccessToken.get!(token, ("/users.info?token=#{token.access_token}&user=#{user_id}"))

    profile = user["profile"]

    name = profile["real_name"]
    avatar = profile["image_48"]
    email = profile["email"]
    phone = profile["phone"]

    Vanpool.UserController.create(%{"user" =>  %{
        "userid" => user_id,
        "avatar_url" => avatar,
        "real_name" => name,
        "slack_handle" => user_name,
        "phone" => phone,
        "email" => email,
      } 
    })

    conn
    |> put_session(:user_id, user_id)
    |> put_session(:current_user, user_name)
    |> put_session(:access_token, token.access_token)
    |> put_session(:token, token)
    |> put_session(:user_real_name, name)
    |> put_session(:user_avatar, avatar)
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
    # this will use local storage to make it happen
  end
end

