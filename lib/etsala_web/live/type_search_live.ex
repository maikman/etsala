defmodule EtsalaWeb.TypeSearchLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Link
  alias EtsalaWeb.Router.Helpers, as: Routes

  @impl true
  def render(assigns) do
    ~L"""
    <form phx-change="suggest">
      <input type="text" name="q" value="<%= @query %>" placeholder="Search..."
             />
             <ul>
             <%= for match <- @matches do %>
             <li><%= link(match, to: Routes.type_path(@socket, :type_details, Tools.Formatter.encode_name(match))) %></li>
           <% end %>
           </ul>
           <%= if @loading, do: "loading ..." %>
    </form>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    send(self(), {:load_all_items})

    {:ok, assign(socket, query: nil, result: nil, loading: true, matches: [])}
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) > 2 do
    result =
      Etsala.Eve.Universe.Types.search_type(query)
      |> Enum.map(& &1.name)
      |> Enum.sort_by(&byte_size/1)

    {:noreply, assign(socket, matches: result)}
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) == 0 do
    send(self(), {:load_all_items})

    {:noreply, assign(socket, query: nil, result: nil, loading: true, matches: [])}
  end

  def handle_event("suggest", %{"q" => _query}, socket) do
    {:noreply, assign(socket, matches: [])}
  end

  def handle_event("search", %{"q" => query}, socket) when byte_size(query) <= 100 do
    send(self(), {:search, query})
    {:noreply, assign(socket, query: query, result: "Searching...", loading: true, matches: [])}
  end

  @impl true
  def handle_info({:load_all_items}, socket) do
    result =
      Etsala.Eve.Universe.Types.list_types()
      |> Enum.map(& &1.name)
      |> Enum.sort(&(&1 <= &2))

    {:noreply,
     assign(socket,
       matches: result,
       loading: false
     )}
  end

  @impl true
  def handle_info({:search, query}, socket) do
    result =
      Etsala.Eve.Universe.Types.search_type(query)
      |> Enum.map(& &1.name)
      |> Enum.sort_by(&byte_size/1)

    {:noreply, assign(socket, loading: false, result: result, matches: [])}
  end
end
