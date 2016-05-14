defmodule GameServer.ChunkController do
  use GameServer.Web, :controller

  alias GameServer.Chunk

  plug :scrub_params, "chunk" when action in [:create, :update]

  def index(conn, _params) do
    chunks = Repo.all(Chunk)
    render(conn, "index.json", chunks: chunks)
  end

  def create(conn, %{"chunk" => chunk_params}) do
    changeset = Chunk.changeset(%Chunk{}, chunk_params)

    case Repo.insert(changeset) do
      {:ok, chunk} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", chunk_path(conn, :show, chunk))
        |> render("show.json", chunk: chunk)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GameServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chunk = Repo.get!(Chunk, id)
    render(conn, "show.json", chunk: chunk)
  end

  def update(conn, %{"id" => id, "chunk" => chunk_params}) do
    chunk = Repo.get!(Chunk, id)
    changeset = Chunk.changeset(chunk, chunk_params)

    case Repo.update(changeset) do
      {:ok, chunk} ->
        render(conn, "show.json", chunk: chunk)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(GameServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chunk = Repo.get!(Chunk, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(chunk)

    send_resp(conn, :no_content, "")
  end
end
