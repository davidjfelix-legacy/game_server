defmodule GameServer.Repo.Migrations.CreateChunk do
  use Ecto.Migration

  def change do
    create table(:chunks) do
      add :address, :string

      timestamps
    end

  end
end
