defmodule Vanpool.User do
  use Vanpool.Web, :model
  

  schema "users" do
    field :userid, :string
    field :avatar_url, :string
    field :real_name, :string
    field :slack_handle, :string
    field :phone, :string
    field :email, :string

    timestamps
  end

  @required_fields ~w(userid avatar_url real_name slack_handle phone email)
  @optional_fields ~w()

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
