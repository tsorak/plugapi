defmodule Plugapi.Route.Htmx do
  use Plug.Router

  alias Plugapi.Templates

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Plugapi.SafeJsonDecoder
  )

  plug(Plugapi.Plugs.JsonValidator)
  plug(Plugapi.Plugs.PutHtmlContentType)

  plug(:dispatch)

  get "/todo" do
    todos = KV.Registry.get_all()

    send_resp(conn, 200, Templates.todos(todos))
  end

  post "/todo" do
    [content_type | _] = get_req_header(conn, "content-type")

    if content_type == "application/json" do
      body = conn.body_params
      name = body |> Map.get("name")

      if not is_nil(name) do
        KV.Registry.create(%Todo{description: name})
        send_resp(conn, 200, Templates.todo_created(name))
      else
        send_resp(conn, 400, "Name is required")
      end
    else
      send_resp(conn, 400, "Content type not supported")
    end
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
