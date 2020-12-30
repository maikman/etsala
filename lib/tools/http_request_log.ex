defmodule Tools.HttpRequestLog do
  @moduledoc """
  HTTP Logs.
  """

  import Ecto.Query, warn: false
  alias Etsala.Repo
  alias Tools.HttpRequestLog.HttpRequestLog

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%HttpRequestLog{}, ...]

  """
  def list_logs do
    Repo.all(HttpRequestLog)
  end

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%HttpRequestLog{}, ...]

  """
  def list_logs_for_insights do
    HttpRequestLog
    |> where([r], r.inserted_at > datetime_add(^NaiveDateTime.utc_now(), -2, "day"))
    |> where([r], r.host == "aida.de")
    |> or_where([r], r.host == "my.aida.de")
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Gets a single log.

  Raises `Ecto.NoResultsError` if the Log does not exist.

  ## Examples

      iex> get_log!(123)
      %Log{}

      iex> get_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log!(id), do: Repo.get!(HttpRequestLog, id)

  @doc """
  Creates a log.

  ## Examples

      iex> create_log(%{field: value})
      {:ok, %Log{}}

      iex> create_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log(attrs \\ %{}) do
    %HttpRequestLog{}
    |> HttpRequestLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a Log.

  ## Examples

      iex> delete_log(log)
      {:ok, %HttpRequestLog{}}

      iex> delete_log(log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log(%HttpRequestLog{} = log) do
    log
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log changes.

  ## Examples

      iex> change_log(log)
      %Ecto.Changeset{source: %HttpRequestLog{}}

  """
  def change_log(%HttpRequestLog{} = log) do
    HttpRequestLog.changeset(log, %{})
  end

  @doc """
  Returns a list of old logs which are certain days old.

  ## Examples

      iex> get_logs_until_date_time(~U[2020-01-15 10:30:58.543442Z])
      [%HttpRequestLog{}, ...]

  """
  def get_logs_until_date_time(date_time) do
    Repo.all(
      HttpRequestLog
      |> where(
        [log],
        log.inserted_at < ^date_time
      )
    )
  end
end
