defmodule GameServer.FactionControllerTest do
  use GameServer.ConnCase

  alias GameServer.Faction
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, faction_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing factions"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, faction_path(conn, :new)
    assert html_response(conn, 200) =~ "New faction"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, faction_path(conn, :create), faction: @valid_attrs
    assert redirected_to(conn) == faction_path(conn, :index)
    assert Repo.get_by(Faction, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, faction_path(conn, :create), faction: @invalid_attrs
    assert html_response(conn, 200) =~ "New faction"
  end

  test "shows chosen resource", %{conn: conn} do
    faction = Repo.insert! %Faction{}
    conn = get conn, faction_path(conn, :show, faction)
    assert html_response(conn, 200) =~ "Show faction"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, faction_path(conn, :show, "667a7537-01ba-4635-a2bf-77beaf84f711")
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    faction = Repo.insert! %Faction{}
    conn = get conn, faction_path(conn, :edit, faction)
    assert html_response(conn, 200) =~ "Edit faction"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    faction = Repo.insert! %Faction{}
    conn = put conn, faction_path(conn, :update, faction), faction: @valid_attrs
    assert redirected_to(conn) == faction_path(conn, :show, faction)
    assert Repo.get_by(Faction, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    faction = Repo.insert! %Faction{}
    conn = put conn, faction_path(conn, :update, faction), faction: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit faction"
  end

  test "deletes chosen resource", %{conn: conn} do
    faction = Repo.insert! %Faction{}
    conn = delete conn, faction_path(conn, :delete, faction)
    assert redirected_to(conn) == faction_path(conn, :index)
    refute Repo.get(Faction, faction.id)
  end
end
