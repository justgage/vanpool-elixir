defmodule Vanpool.UserView do
  use Vanpool.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{ 
      id: user.id,
      real_name: user.real_name,
      slack_handle: user.slack_handle,
      userid: user.userid
    }
  end
end
