defmodule Plugapi.Application do
  use Application
  require Logger

  def start(_type, _args) do
    Plugapi.AssetsCacher.init()

    children = [
      {Plug.Cowboy, scheme: :http, plug: Plugapi.Router, options: [port: 8080]}
    ]

    opts = [strategy: :one_for_one, name: Plugapi.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end
