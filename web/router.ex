defmodule Vanpool.Router do
  use Vanpool.Web, :router
  require Logger

  pipeline :browser do
    # plug :auth
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :assign_env
  end

  pipeline :api do
    # plug :auth_api
    plug :fetch_session
    plug :accepts, ["json"]
   end

  def auth_api(conn, opts) do
    Logger.warn opts

    conn 
    |> Plug.Conn.send_resp(400, %{data: "Sorry your not authenticated"})
    |> halt
  end
  def auth(conn, opts) do
    Logger.warn opts
    conn 
    |> Plug.Conn.send_resp(400, "Sorry your not authed")
    |> halt
  end


  defp assign_env(conn, _) do
    conn
    |> assign(:avatar,         get_session(conn, :current_user))
    |> assign(:current_user,   get_session(conn, :current_user))
    |> assign(:user_id,        get_session(conn, :user_id))
    |> assign(:user_real_name, get_session(conn, :user_real_name))
    |> assign(:user_avatar,    get_session(conn, :user_avatar))
    |> assign(:access_token,          get_session(conn, :access_token))
    # the actual token object
    |> assign(:token,          get_session(conn, :token))
  end


  scope "/", Vanpool do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/users", PageController, :index
    resources "/vans", VanController
  end

  scope "/auth", Vanpool  do
    pipe_through :browser
    get "/", AuthController, :index
    get "/callback", AuthController, :callback
    get "/logout", AuthController, :logout
    get "/userid_login/:userid", AuthController, :login
  end

  # Other scopes may use custom stacks.
  scope "/api", Vanpool do
    pipe_through :api
    resources "/riding", RidingController
    post "/riding/delete_all", RidingController, :delete_all
    resources "/users", UserController
  end

end
