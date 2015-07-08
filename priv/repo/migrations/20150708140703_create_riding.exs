defmodule Vanpool.Repo.Migrations.CreateRiding do
  use Ecto.Migration

  def change do
    create table(:riding) do
      add :dir, :string
      add :userid, :string
      add :vanid, :integer
      add :time, :time
      add :date, :date

      timestamps
    end

  end
end
