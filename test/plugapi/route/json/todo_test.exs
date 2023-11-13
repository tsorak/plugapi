defmodule Plugapi.Route.JsonTest do
  use ExUnit.Case
  use Plug.Test

  alias Plugapi.Router

  @opts Router.init([])

  test "Returns todos as JSON" do
    conn =
      :get
      |> conn("/json/todo", "")
      |> Router.call(@opts)

    assert conn.status == 200

    assert conn
           |> get_resp_header("content-type")
           |> List.first() == "application/json"

    assert conn.resp_body
           |> Jason.decode!()
           |> Enum.all?(&struct(Todo, &1))
  end
end
