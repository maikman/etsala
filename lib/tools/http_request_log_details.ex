defmodule Tools.HttpRequestLogDetails do
  @moduledoc """
  ORCA HTTP Log Details.
  """

  import Ecto.Query, warn: false
  alias Etsala.Repo
  alias Tools.HttpRequestLogDetails.HttpRequestLogDetails

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%HttpRequestLogDetails{}, ...]

  """
  def list_logs do
    Repo.all(HttpRequestLogDetails)
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
  def get_log!(id), do: Repo.get!(HttpRequestLogDetails, id)

  @doc """
  Creates a log.

  ## Examples

      iex> create_log(%{field: value})
      {:ok, %Log{}}

      iex> create_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log(attrs \\ %{}) do
    %HttpRequestLogDetails{}
    |> HttpRequestLogDetails.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a Log.

  ## Examples

      iex> delete_log(log)
      {:ok, %HttpRequestLogDetails{}}

      iex> delete_log(log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log(%HttpRequestLogDetails{} = log) do
    log
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log changes.

  ## Examples

      iex> change_log(log)
      %Ecto.Changeset{source: %HttpRequestLogDetails{}}

  """
  def change_log(%HttpRequestLogDetails{} = log) do
    HttpRequestLogDetails.changeset(log, %{})
  end

  def get_log_by_request_id(request_id) do
    HttpRequestLogDetails
    |> where([r], r.request_id == ^request_id)
    |> Repo.one()
  end
end
