defmodule GameServer.ChunkController do
  use GameServer.Web, :controller

  alias GameServer.Chunk

  plug :scrub_params, "chunk" when action in [:create, :update]

  def index(conn, _params) do
    chunks = Repo.all(Chunk)
    render(conn, "index.html", chunks: chunks)
  end

  def new(conn, _params) do
    changeset = Chunk.changeset(%Chunk{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"chunk" => chunk_params}) do
    changeset = Chunk.changeset(%Chunk{}, chunk_params)

    case Repo.insert(changeset) do
      {:ok, _chunk} ->
        conn
        |> put_flash(:info, "Chunk created successfully.")
        |> redirect(to: chunk_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chunk = Repo.get!(Chunk, id)
    render(conn, "show.html", chunk: chunk)
  end

  def edit(conn, %{"id" => id}) do
    chunk = Repo.get!(Chunk, id)
    changeset = Chunk.changeset(chunk)
    render(conn, "edit.html", chunk: chunk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "chunk" => chunk_params}) do
    chunk = Repo.get!(Chunk, id)
    changeset = Chunk.changeset(chunk, chunk_params)

    case Repo.update(changeset) do
      {:ok, chunk} ->
        conn
        |> put_flash(:info, "Chunk updated successfully.")
        |> redirect(to: chunk_path(conn, :show, chunk))
      {:error, changeset} ->
        render(conn, "edit.html", chunk: chunk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chunk = Repo.get!(Chunk, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(chunk)

    conn
    |> put_flash(:info, "Chunk deleted successfully.")
    |> redirect(to: chunk_path(conn, :index))
  end
end
