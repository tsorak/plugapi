defmodule Plugapi.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Plugapi.Router, options: [port: 8080]},
      KV.Todos
    ]

    opts = [strategy: :one_for_one, name: Plugapi.Supervisor]

    Logger.info("Starting application...")

    _cache_result = Plugapi.AssetsCacher.start([])

    Supervisor.start_link(children, opts)
  end
end
