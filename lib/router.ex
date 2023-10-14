defmodule Plugapi.Router do
  use Plug.Router

  plug(Plug.Static, at: "/assets", from: {:plugapi, "priv/static"})
  plug(:match)
  plug(:dispatch)

  forward("/api", to: Plugapi.ApiRouter)
  forward("/", to: Plugapi.RootRouter)
end
