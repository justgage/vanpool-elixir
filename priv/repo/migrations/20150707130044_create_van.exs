defmodule Vanpool.Repo.Migrations.CreateVan do
  use Ecto.Migration

  def change do
    create table(:vans) do
      add :name, :string
      add :compacity, :integer
      add :come, :string
      add :go, :string

      timestamps
    end

  end
end
