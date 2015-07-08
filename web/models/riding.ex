defmodule Vanpool.Riding do
  use Vanpool.Web, :model

  schema "riding" do
    field :dir, :string
    field :userid, :string
    field :vanid, :integer
    field :time, Ecto.Time
    field :date, Ecto.Date

    timestamps
  end

  @required_fields ~w(dir userid vanid time date)
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
