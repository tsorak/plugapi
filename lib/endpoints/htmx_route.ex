defmodule Plugapi.HtmxRouter do
  use Plug.Router
  require EEx

  plug(:match)
  plug(:dispatch)

  get "/todo" do
    {:ok, body} =
      KV.Todos.get_all()
      |> Jason.encode()

    send_resp(conn, 200, body)
  end

  EEx.function_from_file(:defp, :todo_created, "lib/templates/todo_created.eex", [:todo_name])

  post "/todo" do
    [content_type | _] = get_req_header(conn, "content-type")

    # Early return attempt
    # if content_type !== "application/json" do
    #   send_resp(conn, 400, "Content type not supported")
    #   halt(conn)
    # end

    # {:ok, body, conn} = read_body(conn)

    # name =
    #   Jason.decode!(body)
    #   |> Map.get("name")

    # cond do
    #   is_nil(name) ->
    #     send_resp(conn, 400, "Name is required")

    #   true ->
    #     send_resp(conn, 200, "Todo created")
    # end

    case content_type do
      "application/json" ->
        {:ok, body, conn} = read_body(conn)

        name =
          Jason.decode!(body)
          |> Map.get("name")

        cond do
          is_nil(name) ->
            send_resp(conn, 400, "Name is required")

          true ->
            KV.Todos.create(%Todo{description: name})
            send_resp(conn, 200, todo_created(name))
        end

      _ ->
        send_resp(conn, 400, "Content type not supported")
    end
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
