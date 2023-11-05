defmodule Plugapi.Plugs.JsonValidator do
  @moduledoc false
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    case conn do
      %{body_params: %{"_json" => {:error, :failed_to_parse_json}}} ->
        error = %{message: "Malformed JSON in the request body"}

        conn
        |> put_resp_header("content-type", "application/json; charset=utf-8")
        |> send_resp(400, Jason.encode!(error))
        |> halt

      _ ->
        conn
    end
  end
end
