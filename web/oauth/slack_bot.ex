defmodule SlackBot do
  use HTTPoison.Base

  def process_url(url) do
    "https://slack.com/api/" <> url
  end

  def get_token() do
    System.get_env("VAN_BOT_TOKEN");
  end
  
  def message_fmt(token, slack_handle, text) do
    "?token=#{token}"
    <>"&text=#{text}"
    <>"&channel=@#{slack_handle}"
    <>"&username=VanpoolBot"
  end


  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
