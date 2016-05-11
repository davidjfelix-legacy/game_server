defmodule GameServer.ChunkControllerTest do
  use GameServer.ConnCase

  alias GameServer.Chunk
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chunk_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing chunks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, chunk_path(conn, :new)
    assert html_response(conn, 200) =~ "New chunk"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, chunk_path(conn, :create), chunk: @valid_attrs
    assert redirected_to(conn) == chunk_path(conn, :index)
    assert Repo.get_by(Chunk, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chunk_path(conn, :create), chunk: @invalid_attrs
    assert html_response(conn, 200) =~ "New chunk"
  end

  test "shows chosen resource", %{conn: conn} do
    chunk = Repo.insert! %Chunk{}
    conn = get conn, chunk_path(conn, :show, chunk)
    assert html_response(conn, 200) =~ "Show chunk"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, chunk_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    chunk = Repo.insert! %Chunk{}
    conn = get conn, chunk_path(conn, :edit, chunk)
    assert html_response(conn, 200) =~ "Edit chunk"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    chunk = Repo.insert! %Chunk{}
    conn = put conn, chunk_path(conn, :update, chunk), chunk: @valid_attrs
    assert redirected_to(conn) == chunk_path(conn, :show, chunk)
    assert Repo.get_by(Chunk, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    chunk = Repo.insert! %Chunk{}
    conn = put conn, chunk_path(conn, :update, chunk), chunk: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit chunk"
  end

  test "deletes chosen resource", %{conn: conn} do
    chunk = Repo.insert! %Chunk{}
    conn = delete conn, chunk_path(conn, :delete, chunk)
    assert redirected_to(conn) == chunk_path(conn, :index)
    refute Repo.get(Chunk, chunk.id)
  end
end
