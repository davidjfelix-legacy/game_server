ExUnit.start

Mix.Task.run "ecto.create", ~w(-r GameServer.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r GameServer.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(GameServer.Repo)

