defmodule Plugapi.RootRouter do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_file(conn, 200, "priv/static/index.html")
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
