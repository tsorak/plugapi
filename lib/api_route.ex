defmodule Plugapi.ApiRouter do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Up - #{Mix.env()}")
  end
end
