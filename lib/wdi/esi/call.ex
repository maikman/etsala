defmodule WDI.ESI.Call do
    require Logger
    
    @endpoint Application.get_env(:etsala, :static_endpoints)[:ESI]

    def handle_call(query, params \\ %{}, cache \\ false) do
        [access_token: token] = :ets.lookup(:session, :access_token)
        
        uri = @endpoint.url <> query
        query_params = %{
            datasource: @endpoint.datasource,
            token: token
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
        |> HTTPoison.get!([], timeout: 20000)
        |> Map.get(:body)
        |> Jason.decode()
        |> IO.inspect(label: "http_result")    
    end

    defp cache_result(res, full_url) do
        case res do
            {:ok, result} -> :ets.insert(:esi_calls, {full_url, result})
            _ -> nil
        end

        res
    end

    defp validate_result({:ok, %{"error" => "token is expired", "sso_status" => _}}), do: Logger.error("token is expired")
    defp validate_result({:error, error}), do: Logger.error(error)
    defp validate_result({:ok, result}), do: result
end