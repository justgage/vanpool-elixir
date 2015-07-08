defmodule Vanpool.Van do
  use Vanpool.Web, :model

  schema "vans" do
    field :number, :integer
    field :capacity, :integer
    field :come_time, :string
    field :go_time, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(number capacity come_time go_time description)
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
