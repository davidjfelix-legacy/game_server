defmodule GameServer.Repo.Migrations.CreateChunk do
  use Ecto.Migration

  def change do
    create table(:chunksi, primary_key: false) do
      add :address, :string, primary_key: true

      timestamps
    end

  end
end
