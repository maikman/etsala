defmodule EtsalaWeb.CorpListLive do
  use Phoenix.LiveView
  alias EtsalaWeb.PageView
  alias WDI.ESI.Alliance
  alias EtsalaWeb.Objects.Corporation

  @alliance_id Application.get_env(:etsala, :etsala_legion)[:alliance_id]

  @impl true
  def render(assigns) do
    Phoenix.View.render(PageView, "corp_list_live.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    send(self(), :load_corp_list)

    {:ok,
     assign(socket,
       corps: []
     )}
  end

  @impl true
  def handle_info(:load_corp_list, socket) do
    corps =
      Alliance.get_corporations(@alliance_id)
      |> Enum.map(&Corporation.get_corp(&1))
      |> Enum.sort(&(&1.member_count >= &2.member_count))

    {:noreply,
     assign(socket,
       corps: corps
     )}
  end
end
