defmodule Vanpool.VanController do
  use Vanpool.Web, :controller

  alias Vanpool.Van

  plug :scrub_params, "van" when action in [:create, :update]

  def index(conn, _params) do
    vans = Repo.all(Van)
    render(conn, "index.html", vans: vans)
  end

  def new(conn, _params) do
    changeset = Van.changeset(%Van{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"van" => van_params}) do
    changeset = Van.changeset(%Van{}, van_params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> put_flash(:info, "Van created successfully.")
      |> redirect(to: van_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id, "date" => date}) do
  #   van = Repo.get!(Van, id)
  #   render(conn, "show.html", van: van, date: date)
  # end
  def show(conn, %{"id" => id}) do
    van = Repo.get!(Van, id)

    # how to get today :P
    {date, _} = :calendar.local_time
    date = Ecto.Date.from_erl date

    render(conn, "show.html", van: van, date: date)
  end

  def edit(conn, %{"id" => id}) do
    van = Repo.get!(Van, id)
    changeset = Van.changeset(van)
    render(conn, "edit.html", van: van, changeset: changeset)
  end


  def update(conn, %{"id" => id, "van" => van_params}) do
    van = Repo.get!(Van, id)
    changeset = Van.changeset(van, van_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Van updated successfully.")
      |> redirect(to: van_path(conn, :index))
    else
      render(conn, "edit.html", van: van, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    van = Repo.get!(Van, id)
    Repo.delete!(van)

    conn
    |> put_flash(:info, "Van deleted successfully.")
    |> redirect(to: van_path(conn, :index))
  end
end
