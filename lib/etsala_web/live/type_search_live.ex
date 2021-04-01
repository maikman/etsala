defmodule EtsalaWeb.TypeSearchLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Link
  alias EtsalaWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
    <form phx-change="suggest">
      <input type="text" name="q" value="<%= @query %>" placeholder="Search..."
             <%= if @loading, do: "readonly" %>/>
             <ul>
             <%= for match <- @matches do %>
             <li><%= link(match, to: Routes.type_path(@socket, :type_details, Tools.Formatter.encode_name(match))) %></li>
           <% end %>
           </ul>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    send(self(), {:search, ""})

    {:ok, assign(socket, query: nil, result: nil, loading: false, matches: [])}
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) > 2 do
    result =
      Etsala.Eve.Universe.Types.search_type(query)
      |> Enum.map(& &1.name)
      |> Enum.sort_by(&byte_size/1)

    {:noreply, assign(socket, matches: result)}
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) == 0 do
    send(self(), {:search, ""})

    {:noreply, assign(socket, matches: [])}
  end

  def handle_event("suggest", %{"q" => _query}, socket) do
    {:noreply, assign(socket, matches: [])}
  end

  def handle_event("search", %{"q" => query}, socket) when byte_size(query) <= 100 do
    send(self(), {:search, query})
    {:noreply, assign(socket, query: query, result: "Searching...", loading: true, matches: [])}
  end

  def handle_info({:search, ""}, socket) do
    result =
      Etsala.Eve.Universe.Types.list_types()
      |> Enum.map(& &1.name)
      |> Enum.sort(&(&1 <= &2))

    {:noreply, assign(socket, loading: false, result: result, matches: result)}
  end

  def handle_info({:search, query}, socket) do
    result =
      Etsala.Eve.Universe.Types.search_type(query)
      |> Enum.map(& &1.name)
      |> Enum.sort_by(&byte_size/1)

    {:noreply, assign(socket, loading: false, result: result, matches: [])}
  end
end
