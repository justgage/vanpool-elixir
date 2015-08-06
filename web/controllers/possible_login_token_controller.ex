defmodule Vanpool.PossibleLoginTokenController do
  use Vanpool.Web, :controller

  alias Vanpool.PossibleLoginToken

  plug :scrub_params, "possible_login_token" when action in [:create, :update]

  def index(conn, _params) do
    possibleLoginTokens = Repo.all(PossibleLoginToken)
    render(conn, "index.html", possibleLoginTokens: possibleLoginTokens)
  end

  def new(conn, _params) do
    changeset = PossibleLoginToken.changeset(%PossibleLoginToken{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"possible_login_token" => possible_login_token_params}) do
    changeset = PossibleLoginToken.changeset(%PossibleLoginToken{}, possible_login_token_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "PossibleLoginToken created successfully.")
      |> redirect(to: possible_login_token_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    possible_login_token = Repo.get!(PossibleLoginToken, id)
    render(conn, "show.html", possible_login_token: possible_login_token)
  end

  def edit(conn, %{"id" => id}) do
    possible_login_token = Repo.get!(PossibleLoginToken, id)
    changeset = PossibleLoginToken.changeset(possible_login_token)
    render(conn, "edit.html", possible_login_token: possible_login_token, changeset: changeset)
  end

  def update(conn, %{"id" => id, "possible_login_token" => possible_login_token_params}) do
    possible_login_token = Repo.get!(PossibleLoginToken, id)
    changeset = PossibleLoginToken.changeset(possible_login_token, possible_login_token_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "PossibleLoginToken updated successfully.")
      |> redirect(to: possible_login_token_path(conn, :index))
    else
      render(conn, "edit.html", possible_login_token: possible_login_token, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    possible_login_token = Repo.get!(PossibleLoginToken, id)
    Repo.delete!(possible_login_token)

    conn
    |> put_flash(:info, "PossibleLoginToken deleted successfully.")
    |> redirect(to: possible_login_token_path(conn, :index))
  end
end
