defmodule Vanpool.RidingView do
  use Vanpool.Web, :view

  def render("index.json", %{riding: riding}) do
    %{data: render_many(riding, "riding.json")}
  end

  def render("show.json", %{riding: riding}) do
    %{data: render_one(riding, "riding.json")}
  end

  def render("riding.json", %{riding: riding}) do
    %{id: riding.id, userid: riding.userid}
  end
end
