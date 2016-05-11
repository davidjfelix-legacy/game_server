defmodule GameServer.EntityTest do
  use GameServer.ModelCase

  alias GameServer.Entity

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Entity.changeset(%Entity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entity.changeset(%Entity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
