defmodule Plugapi.Route.Json do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Plugapi.SafeJsonDecoder
  )

  plug(Plugapi.Plugs.JsonValidator)

  get "/" do
    send_resp(conn, 200, "Up - #{Mix.env()}")
  end

  get "/todo" do
    {:ok, todos} =
      KV.Registry.get_all()
      |> Jason.encode()

    send_resp(conn, 200, todos)
  end
end
