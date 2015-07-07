defmodule Vanpool.Van do
  use Vanpool.Web, :model

  schema "vans" do
    field :name, :string
    field :compacity, :integer
    field :come, :string
    field :go, :string

    timestamps
  end

  @required_fields ~w(name compacity come go)
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
