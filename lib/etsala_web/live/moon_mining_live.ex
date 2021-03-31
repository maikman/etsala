defmodule EtsalaWeb.MoonMiningLive do
  use Phoenix.LiveView
  alias EtsalaWeb.OreView
  alias Etsala.Eve.Market.Order
  alias WDI.ESI.Images

  @ore_data Application.get_env(:etsala, :ore)[:ubiquitous]

  @impl true
  def render(assigns) do
    Phoenix.View.render(OreView, "moon_mining_live.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    send(self(), :load_ore_data)

    {:ok,
     assign(socket,
       materials: [],
       ore_list: []
     )}
  end

  @impl true
  def handle_info(:load_ore_data, socket) do
    materials =
      @ore_data.materials
      |> Enum.map(&add_average_prices(&1))
      |> Enum.map(&add_image(&1))
      |> Enum.sort(&(&1.price <= &2.price))

    ore_list =
      @ore_data.types
      |> Enum.map(&calculate_revenue(&1, materials))
      |> Enum.map(&add_image(&1))
      |> Enum.map(&add_reprocessing_infos(&1, materials))
      |> Enum.sort(&(&1.revenue >= &2.revenue))

    {:noreply,
     assign(socket,
       materials: materials,
       ore_list: ore_list
     )}
  end

  defp add_average_prices(material) do
    price =
      material.id
      |> Order.get_jita_buy_order_price_average()

    material |> Map.put_new(:price, price)
  end

  defp calculate_revenue(type, prices) do
    revenue = type.industry |> Enum.map(&get_unit_price(&1.id, &1.units, prices)) |> Enum.sum()

    type |> Map.put_new(:revenue, revenue)
  end

  defp get_unit_price(id, units, prices) do
    prices |> Enum.find(&(&1.id == id)) |> Map.get(:price) |> Kernel.*(units)
  end

  defp add_image(type) do
    image = Images.get_image(type.id, 64)
    type |> Map.put_new(:image, image)
  end

  defp add_reprocessing_infos(type, materials) do
    display_industry =
      type.industry
      |> Enum.map(fn mat ->
        materials |> Enum.find(&(mat.id == &1.id)) |> Map.take([:name, :image]) |> Map.merge(mat)
      end)

    type |> Map.put(:industry, display_industry)
  end
end
