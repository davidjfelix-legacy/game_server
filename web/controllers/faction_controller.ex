defmodule GameServer.FactionController do
  use GameServer.Web, :controller

  alias GameServer.Faction

  plug :scrub_params, "faction" when action in [:create, :update]

  def index(conn, _params) do
    factions = Repo.all(Faction)
    render(conn, "index.html", factions: factions)
  end

  def new(conn, _params) do
    changeset = Faction.changeset(%Faction{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"faction" => faction_params}) do
    changeset = Faction.changeset(%Faction{}, faction_params)

    case Repo.insert(changeset) do
      {:ok, _faction} ->
        conn
        |> put_flash(:info, "Faction created successfully.")
        |> redirect(to: faction_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    faction = Repo.get!(Faction, id)
    render(conn, "show.html", faction: faction)
  end

  def edit(conn, %{"id" => id}) do
    faction = Repo.get!(Faction, id)
    changeset = Faction.changeset(faction)
    render(conn, "edit.html", faction: faction, changeset: changeset)
  end

  def update(conn, %{"id" => id, "faction" => faction_params}) do
    faction = Repo.get!(Faction, id)
    changeset = Faction.changeset(faction, faction_params)

    case Repo.update(changeset) do
      {:ok, faction} ->
        conn
        |> put_flash(:info, "Faction updated successfully.")
        |> redirect(to: faction_path(conn, :show, faction))
      {:error, changeset} ->
        render(conn, "edit.html", faction: faction, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    faction = Repo.get!(Faction, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(faction)

    conn
    |> put_flash(:info, "Faction deleted successfully.")
    |> redirect(to: faction_path(conn, :index))
  end
end
