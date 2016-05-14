defmodule GameServer.ChunkView do
  use GameServer.Web, :view

  def render("index.json", %{chunks: chunks}) do
    %{data: render_many(chunks, GameServer.ChunkView, "chunk.json")}
  end

  def render("show.json", %{chunk: chunk}) do
    %{data: render_one(chunk, GameServer.ChunkView, "chunk.json")}
  end

  def render("chunk.json", %{chunk: chunk}) do
    %{address: chunk.address}
  end
end
