defmodule GameServer.ChunkControllerTest do
  use GameServer.ConnCase

  alias GameServer.Chunk
  @valid_attrs %{address: "some content"}
  @invalid_attrs %{address: 1}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chunk_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    chunk = Repo.insert! %Chunk{address: "1"}
    conn = get conn, chunk_path(conn, :show, chunk)
    assert json_response(conn, 200)["data"] == %{"address" => chunk.address}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, chunk_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, chunk_path(conn, :create), chunk: @valid_attrs
    assert json_response(conn, 201)["data"]["address"]
    assert Repo.get_by(Chunk, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chunk_path(conn, :create), chunk: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    chunk = Repo.insert! %Chunk{address: "1"}
    conn = put conn, chunk_path(conn, :update, chunk), chunk: @valid_attrs
    assert json_response(conn, 200)["data"]["address"]
    assert Repo.get_by(Chunk, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    chunk = Repo.insert! %Chunk{address: "1"}
    conn = put conn, chunk_path(conn, :update, chunk), chunk: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    chunk = Repo.insert! %Chunk{address: "a"}
    conn = delete conn, chunk_path(conn, :delete, chunk)
    assert response(conn, 204)
    refute Repo.get(Chunk, chunk.address)
  end
end
