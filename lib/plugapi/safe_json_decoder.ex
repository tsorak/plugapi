defmodule Plugapi.SafeJsonDecoder do
  @moduledoc false

  def decode!(body) do
    case Jason.decode(body) do
      {:ok, parsed} -> parsed
      _ -> {:error, :failed_to_parse_json}
    end
  end
end
