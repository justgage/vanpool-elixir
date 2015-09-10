defmodule Vanpool.Router do
  use Vanpool.Web, :router
  require Logger

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :auth
    plug :fetch_flash
    plug :protect_from_forgery
    plug :assign_env
  end

  pipeline :browser_unauth do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :assign_env
  end

  pipeline :api do
    plug :fetch_session
    plug :accepts, ["json"]
    plug :auth_api
   end

  @doc """
  This will make sure the right sesson stuff is set
  """
  defp check_auth(conn) do
    user = get_session(conn, :current_user)
    user != nil
  end

  def auth_api(conn, _opts) do
    if check_auth(conn) do
      conn 
    else
      conn
      |> Plug.Conn.send_resp(400, "{\"error\": \"Sorry your not authed\"}")
      |> halt
    end
  end

  def auth(conn, _opts) do
    if check_auth(conn) do
      conn 
    else
      conn
      |> Phoenix.Controller.redirect(to: "/auth/login")
      |> halt
    end
  end


  defp assign_env(conn, _) do
    conn
    |> assign(:current_user, get_session(conn, :current_user))
  end

  scope "/auth", Vanpool do
    pipe_through :browser_unauth # Use the default browser stack

    get "/", AuthController, :index
    get "/callback", AuthController, :callback
    get "/logout", AuthController, :logout
    get "/userid_login/:userid", AuthController, :login
    get "/login",           PageController, :login
  end

  scope "/", Vanpool do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/users", PageController, :index
    resources "/vans", VanController
  end

  scope "/api", Vanpool do
    pipe_through :api
    resources "/riding", RidingController
    post "/riding/delete_all", RidingController, :delete_all
    resources "/users", UserController
    resources "/login_token", LoginTokenController
  end

end
