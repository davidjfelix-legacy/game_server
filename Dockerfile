FROM elixir

WORKDIR /opt/game_server

COPY ./mix.exs /opt/gameserver
RUN mix deps.get

COPY ./ /opt/game_server
RUN mix build
