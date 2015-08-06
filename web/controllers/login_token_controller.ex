defmodule Vanpool.LoginTokenController do
  use Vanpool.Web, :controller

  alias Vanpool.LoginToken

  plug :scrub_params, "login_token" when action in [:create, :update]

  def index(conn, _params) do
    loginTokens = Repo.all(LoginToken)
    render(conn, "index.json", loginTokens: loginTokens)
  end

  def create(conn, %{"login_token" => login_token_params}) do
    changeset = LoginToken.changeset(%LoginToken{}, login_token_params)

    if changeset.valid? do
      login_token = Repo.insert!(changeset)
      render(conn, "show.json", login_token: login_token)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Vanpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    login_token = Repo.get!(LoginToken, id)
    render conn, "show.json", login_token: login_token
  end

  def update(conn, %{"id" => id, "login_token" => login_token_params}) do
    login_token = Repo.get!(LoginToken, id)
    changeset = LoginToken.changeset(login_token, login_token_params)

    if changeset.valid? do
      login_token = Repo.update!(changeset)
      render(conn, "show.json", login_token: login_token)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Vanpool.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    login_token = Repo.get!(LoginToken, id)

    login_token = Repo.delete!(login_token)
    render(conn, "show.json", login_token: login_token)
  end
end
