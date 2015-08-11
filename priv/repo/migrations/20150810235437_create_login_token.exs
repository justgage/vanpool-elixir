defmodule Vanpool.Repo.Migrations.CreateLoginToken do
  use Ecto.Migration

  def change do
    create table(:loginTokens) do
      add :slackHandle, :string
      add :token, :string

      timestamps
    end

  end
end
