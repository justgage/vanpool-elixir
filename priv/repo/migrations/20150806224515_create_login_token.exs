defmodule Vanpool.Repo.Migrations.CreateLoginToken do
  use Ecto.Migration

  def change do
    create table(:loginTokens) do
      add :userId, :integer
      add :tokens, :string

      timestamps
    end

  end
end
