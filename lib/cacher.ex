defmodule Plugapi.AssetsCacher do
  use GenServer
  require Logger

  def init(_arg) do
    Logger.info("Starting AssetsCacher...")
    {:ok, :ok}
  end

  def start_link(_arg) do
    cache_htmx()
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def cache_htmx do
    Logger.info("Caching HTMX...")
    cache("https://unpkg.com/htmx.org@1.9.6/dist/htmx.min.js", "htmx.js")
    cache("https://unpkg.com/htmx.org@1.9.6/dist/ext/json-enc.js", "htmx-json-enc.js")
  end

  defp cache(url, save_name) do
    {_, script_data} = fetch_script(url)
    write_file(script_data, save_name)
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
