defmodule Plugapi.HtmxRouter do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    htmx = "<h1>Hello World!</h1>"

    send_resp(conn, 200, htmx)
  end
end
