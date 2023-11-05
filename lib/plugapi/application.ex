defmodule Plugapi.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Plugapi.Router, options: [port: 8080]},
      KV.Registry
    ]

    opts = [strategy: :one_for_one, name: Plugapi.Supervisor]

    Logger.info("Starting application...")

    Task.async(fn -> Plugapi.AssetsCacher.start([]) end)

    Logger.info("Starting webserver...")

    Supervisor.start_link(children, opts)
  end
end
