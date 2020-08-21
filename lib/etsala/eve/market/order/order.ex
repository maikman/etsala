defmodule Etsala.Eve.Market.Order.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :duration, :integer
    field :is_buy_order, :boolean, default: false
    field :issued, :string
    field :location_id, :integer
    field :min_volume, :integer
    field :order_id, :integer
    field :price, :float
    field :range, :string
    field :system_id, :integer
    field :type_id, :integer
    field :volume_remain, :integer
    field :volume_total, :integer

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:duration, :is_buy_order, :issued, :location_id, :min_volume, :order_id, :price, :range, :system_id, :type_id, :volume_remain, :volume_total])
    |> validate_required([:duration, :is_buy_order, :issued, :location_id, :min_volume, :order_id, :price, :range, :system_id, :type_id, :volume_remain, :volume_total])
    |> unique_constraint(:order_id)
  end
end
