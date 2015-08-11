defmodule Vanpool.LoginTokenView do
  use Vanpool.Web, :view

  def render("index.json", %{loginTokens: loginTokens}) do
    %{data: render_many(loginTokens, "login_token.json")}
  end

  def render("show.json", %{login_token: login_token}) do
    %{data: render_one(login_token, "login_token.json")}
  end

  def render("login_token.json", %{login_token: login_token}) do
    %{id: login_token.id}
  end
end
