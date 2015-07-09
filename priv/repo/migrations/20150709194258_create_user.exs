defmodule Vanpool.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :userid, :string
      add :avatar_url, :string
      add :real_name, :string
      add :slack_handle, :string
      add :phone, :string
      add :email, :string

      timestamps
    end

  end
end
