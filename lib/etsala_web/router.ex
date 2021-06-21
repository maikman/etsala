defmodule EtsalaWeb.Router do
  use EtsalaWeb, :router
  use Plug.ErrorHandler

  alias Tools.LogBackend.RouterError

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {EtsalaWeb.LayoutView, :root}
    plug EtsalaWeb.Plugs.SSO
    plug EtsalaWeb.Plugs.User
    plug EtsalaWeb.Plugs.Tracking
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EtsalaWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/changelog", PageController, :changelog
    get "/callback", PageController, :callback
    get "/logout", PageController, :logout

    get "/eve-online/types", TypeController, :types
    get "/eve-online/types/:id", TypeController, :type_details
    get "/types/:id", TypeController, :type_details_old
    # live "/eve-online/types/:id", TypeDetailsLive
    live "/eve-online/type-search", TypeSearchLive

    get "/market/own-orders", MarketController, :character_market_orders
    get "/market/structure/:id", MarketController, :structure_market_orders

    get "/market/optimize/:structure_id",
        MarketController,
        :structure_optimizer

    get "/recruitment", RecruitmentController, :index

    get "/alliance", CorporationController, :index
    get "/corporation", CorporationController, :index
    get "/corporation/:id", CorporationController, :corp_detail

    get "/moon-mining/:type", OreController, :moon_mining

    get "/calendar", CalendarController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", EtsalaWeb do
  #   pipe_through :api
  # end

  def handle_errors(conn, %{kind: _kind, reason: reason, stack: stack}) do
    RouterError.handle_router_error(conn, %{reason: reason, stack: stack})
  end
end
