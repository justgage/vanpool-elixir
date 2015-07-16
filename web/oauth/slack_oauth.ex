defmodule SlackOAuth2 do
  @moduledoc """
  An OAuth2 strategy for Slack.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  # Public API

  def new do
    OAuth2.new([
      strategy: __MODULE__,
      client_id: System.get_env("SLACK_CLIENT_ID"),
      client_secret: System.get_env("SLACK_CLIENT_SECRET"),
      redirect_uri: System.get_env("SLACK_REDIRECT_URI"),
      site: "https://slack.com/api",
      authorize_url: "https://slack.com/oauth/authorize",
      token_url: "https://slack.com/api/oauth.access",
    ])
  end

  def authorize_url!(params \\ []) do

    params = params ++ [team: "T028ZAGUD", scope: "identify,read"]

    new()
    |> OAuth2.Client.authorize_url!(params)
  end

  def get_token!(params \\ [], _headers \\ []) do
    OAuth2.Client.get_token!(new(), params)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end

  def is_authed?(conn) do
    Plug.Conn.get_session(conn, :user_id) != nil
  end

end
