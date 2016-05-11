defmodule GameServer.EntityControllerTest do
  use GameServer.ConnCase

  alias GameServer.Entity
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, entity_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing entities"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, entity_path(conn, :new)
    assert html_response(conn, 200) =~ "New entity"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, entity_path(conn, :create), entity: @valid_attrs
    assert redirected_to(conn) == entity_path(conn, :index)
    assert Repo.get_by(Entity, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, entity_path(conn, :create), entity: @invalid_attrs
    assert html_response(conn, 200) =~ "New entity"
  end

  test "shows chosen resource", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = get conn, entity_path(conn, :show, entity)
    assert html_response(conn, 200) =~ "Show entity"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, entity_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = get conn, entity_path(conn, :edit, entity)
    assert html_response(conn, 200) =~ "Edit entity"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = put conn, entity_path(conn, :update, entity), entity: @valid_attrs
    assert redirected_to(conn) == entity_path(conn, :show, entity)
    assert Repo.get_by(Entity, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = put conn, entity_path(conn, :update, entity), entity: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit entity"
  end

  test "deletes chosen resource", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = delete conn, entity_path(conn, :delete, entity)
    assert redirected_to(conn) == entity_path(conn, :index)
    refute Repo.get(Entity, entity.id)
  end
end
