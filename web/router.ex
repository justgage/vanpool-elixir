defmodule Vanpool.Router do
  use Vanpool.Web, :router


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :assign_current_user
  end

  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end

  pipeline :api do
    plug :accepts, ["json"]
   end

  scope "/", Vanpool do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/vans", VanController
    resources "/users", UserController
    resources "/riding", RidingController
  end

  scope "/auth", Vanpool  do
    pipe_through :browser
    get "/", AuthController, :index
    get "/callback", AuthController, :callback
    get "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", Vanpool do
  #   pipe_through :api
  # end
end
