defmodule Plugapi.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  forward("/api", to: Plugapi.ApiRouter)
  forward("/", to: Plugapi.RootRouter)
end
