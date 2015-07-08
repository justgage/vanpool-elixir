defmodule Vanpool.Repo.Migrations.CreateVan do
  use Ecto.Migration

  def change do
    create table(:vans) do
      add :number, :integer
      add :capacity, :integer
      add :come_time, :string
      add :go_time, :string
      add :description, :string

      timestamps
    end

  end
end
