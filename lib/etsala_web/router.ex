defmodule EtsalaWeb.Router do
  use EtsalaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug EtsalaWeb.Plugs.SSO
    plug EtsalaWeb.Plugs.Cache
    plug EtsalaWeb.Plugs.User
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EtsalaWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/callback", PageController, :callback
    get "/logout", PageController, :logout

    get "/types", TypeController, :types
    get "/types/:id", TypeController, :type_detail

    get "/market/own-orders", MarketController, :character_market_orders
    get "/market/structure/:id", MarketController, :structure_market_orders

    get "/market/compare/:structure_id",
        MarketController,
        :structure_optimizer

    get "/recruitment", RecruitmentController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", EtsalaWeb do
  #   pipe_through :api
  # end
end
