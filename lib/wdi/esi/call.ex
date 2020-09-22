defmodule WDI.ESI.Call do
  require Logger

  @endpoint Application.get_env(:etsala, :static_endpoints)[:ESI]

  def handle_call(query, params \\ %{}, cache \\ false) do
    uri = @endpoint.url <> query

    query_params =
      %{
        datasource: @endpoint.datasource
      }
      |> Map.merge(params)
      |> URI.encode_query()

    "#{uri}?#{query_params}"
    |> get_result(cache)
    |> validate_result()
    |> case do
      {:ok, result} ->
        result

      {:retry, _} ->
        Logger.info("RETRY QUERY: #{uri}?#{query_params}")
        handle_call(query, params, cache)

      _ ->
        nil
    end
  end

  defp get_result(full_url, true) do
    :ets.lookup(:esi_calls, full_url)
    |> case do
      [{_full_url, result}] -> {:ok, result}
      [] -> get_result(full_url, false) |> cache_result(full_url)
      _ -> {:error, "Caching Error"}
    end
  end

  defp get_result(full_url, false) do
    full_url
    |> HTTPoison.get([], timeout: 20000)
    |> get_result_from_response(full_url)
    |> case do
      {:ok, result} -> result |> Map.get(:body) |> Jason.decode()
      {:error, _} -> nil
      {:timeout, url} -> get_result(url, false)
    end
  end

  defp get_result_from_response({:ok, result}, _full_url), do: {:ok, result}

  defp get_result_from_response({:error, %HTTPoison.Error{id: nil, reason: :timeout}}, full_url) do
    Process.sleep(5000)
    Logger.warn("timeout! Retry in 5 seconds")
    {:timeout, full_url}
  end

  defp get_result_from_response({:error, result}, _full_url) do
    {:error, result}
  end

  defp cache_result(res, full_url) do
    case res do
      {:ok, result} -> :ets.insert(:esi_calls, {full_url, result})
      _ -> nil
    end

    res
  end

  defp validate_result({:ok, %{"error" => "token is expired", "sso_status" => _}}),
    do: Logger.error("token is expired")

  defp validate_result({:error, error = %Jason.DecodeError{}}) do
    cond do
      error.data =~ "502 Bad Gateway" -> {:retry, nil}
      true -> Logger.error(error.data)
    end
  end

  defp validate_result({:error, _}), do: Logger.error("UNDEFINED ERROR")
  defp validate_result({:ok, result}), do: {:ok, result}
end
