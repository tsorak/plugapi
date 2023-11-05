defmodule Plugapi.Plugs.PutHtmlContentType do
  @moduledoc false
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn |> put_resp_content_type("text/html")
  end
end
