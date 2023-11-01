defmodule Plugapi.Router do
  use Plug.Router

  plug(Plug.Static, at: "/assets", from: {:plugapi, "priv/static"})
  plug(:match)
  plug(:dispatch)

  forward("/htmx", to: Plugapi.Route.Htmx)
  forward("/api", to: Plugapi.Route.Api)
  forward("/", to: Plugapi.Route.Root)
end
