defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ApiWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ApiWeb do
    pipe_through :api
    post "/users", UserController, :create
    get "/users", UserController, :retrieveAll
    get "/users/:userID", UserController, :retrieve
    put "/users/:userID", UserController, :update
    delete "/users/:userID", UserController, :delete

    post "/workingtimes/:userID", WorkingTimeController, :create
    get "/workingtimes/:userID", WorkingTimeController, :retrieveAll
    get "/users/:userID/workingtimes/:id", WorkingTimeController, :retrieve
    put "/workingtimes/:id", WorkingTimeController, :update
    delete "/workingtimes/:id", WorkingTimeController, :delete

    post "/clocks", ClocksController, :create
    put "/clocks/:id", ClocksController, :update
    get "/clocks/:userID", ClocksController, :retrieve
  end
end
