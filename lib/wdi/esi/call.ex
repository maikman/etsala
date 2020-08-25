defmodule WDI.ESI.Call do
    require Logger
    
    @endpoint Application.get_env(:etsala, :static_endpoints)[:ESI]

    def handle_call(query, params \\ %{}, cache \\ false) do        
        uri = @endpoint.url <> query
        query_params = %{
            datasource: @endpoint.datasource
        } |> Map.merge(params)
        |> URI.encode_query()

        "#{uri}?#{query_params}"
        |> get_result(cache)
        |> validate_result()
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
        |> Map.get(:body)
        |> Jason.decode()
    end

    defp get_result_from_response({:ok, result}, _full_url), do: result

    defp get_result_from_response({:error, result}, full_url) do
        IO.inspect(result, label: "ERROR")
        Process.sleep(2000)
        Logger.warn("timeout! Retry in 2 seconds")
        get_result(full_url, false)
        |> get_result_from_response(full_url)
    end

    defp cache_result(res, full_url) do
        case res do
            {:ok, result} -> :ets.insert(:esi_calls, {full_url, result})
            _ -> nil
        end

        res
    end

    defp validate_result({:ok, %{"error" => "token is expired", "sso_status" => _}}), do: Logger.error("token is expired")
    defp validate_result({:error, error = %Jason.DecodeError{}}), do: Logger.error(error.data)
    defp validate_result({:error, _}), do: Logger.error("UNDEFINED ERROR")
    defp validate_result({:ok, result}), do: result
end