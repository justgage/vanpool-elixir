defmodule Vanpool.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :bio, :string
      add :slack_handle, :string
      add :access_token, :string

      timestamps
    end

  end
end
