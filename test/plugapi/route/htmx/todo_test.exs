defmodule Plugapi.Route.HtmxTest do
  use ExUnit.Case
  use Plug.Test

  alias Plugapi.Router

  @opts Router.init([])

  test "Sends todos back in html format" do
    KV.Registry.create(%Todo{description: "Test", done: false})

    conn =
      :get
      |> conn("/htmx/todo", "")
      |> Router.call(@opts)

    %{resp_body: body} = conn

    assert conn.status == 200

    assert conn
           |> get_resp_header("content-type")
           |> List.first() == "text/html"

    assert String.length(body) > 0
  end
end
