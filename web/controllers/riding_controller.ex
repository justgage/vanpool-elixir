defmodule Vanpool.RidingController do
  use Vanpool.Web, :controller

  alias Vanpool.Riding

  plug :scrub_params, "riding" when action in [:create, :update]

  def index(conn, _params) do
    riding = Repo.all(Riding)
    render(conn, "index.html", riding: riding)
  end

  def new(conn, _params) do
    changeset = Riding.changeset(%Riding{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"riding" => riding_params}) do
    changeset = Riding.changeset(%Riding{}, riding_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Riding created successfully.")
      |> redirect(to: riding_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    riding = Repo.get!(Riding, id)
    render(conn, "show.html", riding: riding)
  end

  def edit(conn, %{"id" => id}) do
    riding = Repo.get!(Riding, id)
    changeset = Riding.changeset(riding)
    render(conn, "edit.html", riding: riding, changeset: changeset)
  end

  def update(conn, %{"id" => id, "riding" => riding_params}) do
    riding = Repo.get!(Riding, id)
    changeset = Riding.changeset(riding, riding_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Riding updated successfully.")
      |> redirect(to: riding_path(conn, :index))
    else
      render(conn, "edit.html", riding: riding, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    riding = Repo.get!(Riding, id)
    Repo.delete!(riding)

    conn
    |> put_flash(:info, "Riding deleted successfully.")
    |> redirect(to: riding_path(conn, :index))
  end
end
