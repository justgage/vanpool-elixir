defmodule Vanpool.LoginToken do
  use Vanpool.Web, :model

  schema "loginTokens" do
    field :userId, :integer
    field :tokens, :string

    timestamps
  end

  @required_fields ~w(userId tokens)
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
