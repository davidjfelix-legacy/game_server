defmodule GameServer.ChunkTest do
  use GameServer.ModelCase

  alias GameServer.Chunk

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Chunk.changeset(%Chunk{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Chunk.changeset(%Chunk{}, @invalid_attrs)
    refute changeset.valid?
  end
end
