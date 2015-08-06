defmodule Vanpool.Repo.Migrations.CreatePossibleLoginToken do
  use Ecto.Migration

  def change do
    create table(:possibleLoginTokens) do
      add :userId, :integer
      add :tokens, :string

      timestamps
    end

  end
end
