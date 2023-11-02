defmodule Plugapi.Route.Htmx do
  use Plug.Router
  require EEx

  plug(:match)
  plug(:dispatch)

  EEx.function_from_file(:defp, :todos, "lib/templates/todos.eex", [:todos])

  get "/todo" do
    todos = KV.Registry.get_all()

    send_resp(conn, 200, todos(todos))
  end

  EEx.function_from_file(:defp, :todo_created, "lib/templates/todo_created.eex", [:todo_name])

  post "/todo" do
    [content_type | _] = get_req_header(conn, "content-type")

    if content_type == "application/json" do
      {:ok, body, conn} = read_body(conn)

      name =
        Jason.decode!(body)
        |> Map.get("name")

      if not is_nil(name) do
        KV.Registry.create(%Todo{description: name})
        send_resp(conn, 200, todo_created(name))
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
