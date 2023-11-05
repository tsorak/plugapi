defmodule Plugapi.AssetsCacher do
  require Logger

  def start(_opts) do
    Logger.info("Starting AssetsCacher...")
    cache_htmx()
  end

  def cache_htmx do
    Logger.info("Caching HTMX...")

    htmx_cache_result = cache("https://unpkg.com/htmx.org@1.9.6/dist/htmx.min.js", "htmx.js")

    htmx_json_enc_cache_result =
      cache("https://unpkg.com/htmx.org@1.9.6/dist/ext/json-enc.js", "htmx-json-enc.js")

    Enum.all?([htmx_cache_result, htmx_json_enc_cache_result], fn {result, _} -> result == :ok end)
    |> if do
      :ok
    else
      :error
    end
  end

  defp cache(url, save_name) do
    {fetch_result, script_data} = fetch_script(url)

    if fetch_result == :error do
      {:error, :fetch_error}
    else
      write_file(script_data, save_name)
    end
  end

  defp fetch_script(url) do
    case HTTPoison.get(url) do
      {:ok,
       %HTTPoison.Response{
         status_code: 200,
         body: body
       }} ->
        Logger.info("Fetched #{url}")
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("Failed to fetch #{url}")
        {:error, :not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Failed to fetch #{url}: #{reason}")
        {:error, reason}
    end
  end

  defp write_file(data, save_name) do
    case File.write("priv/static/#{save_name}", data) do
      {:error, err} ->
        Logger.error("Failed to write file #{save_name} (#{err})")
        {:error, :write_error}

      _ ->
        Logger.info("Wrote file #{save_name}")
        {:ok, save_name}
    end
  end
end
