defmodule Plugapi.Plugs.PutHtmlContentType do
  @moduledoc false
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn |> put_resp_header("content-type", "text/html")
  end
end
