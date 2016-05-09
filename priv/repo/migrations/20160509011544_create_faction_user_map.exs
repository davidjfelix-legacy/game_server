defmodule GameServer.Repo.Migrations.CreateFactionUserMap do
  use Ecto.Migration

  def change do
    create table(:faction_users) do
      add :faction_id, references(:factions, type: :uuid)
      add :user_id, references(:users, type: :uuid)

      timestamps
    end
  end
end
