defmodule Vanpool.Router do
  use Vanpool.Web, :router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :assign_env
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

  pipeline :api do
    plug :fetch_session
    plug :accepts, ["json"]
   end

  scope "/", Vanpool do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/vans", VanController
  end

  scope "/auth", Vanpool  do
    pipe_through :browser
    get "/", AuthController, :index
    get "/callback", AuthController, :callback
    get "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  scope "/api", Vanpool do
    pipe_through :api
    resources "/riding", RidingController
    resources "/users", UserController
  end
end
