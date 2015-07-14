defmodule Vanpool.User do
  use Vanpool.Web, :model
  

  schema "users" do
    field :userid, :string
    field :avatar_url, :string
    field :real_name, :string
    field :slack_handle, :string
    field :phone, :string, default: ""
    field :email, :string, default: ""

    timestamps
  end

  @required_fields ~w(userid avatar_url slack_handle)
  @optional_fields ~w(phone email real_name)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
