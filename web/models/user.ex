defmodule Vanpool.User do
  use Vanpool.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :string
    field :slack_handle, :string
    field :access_token, :string

    timestamps
  end

  @required_fields ~w(name email bio slack_handle access_token)
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

  def save_user(user, token) do
    # save the token and avatar in a better way
  end
end
