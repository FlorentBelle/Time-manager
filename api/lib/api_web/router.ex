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

    post "/working_times", WorkingTimeController, :create
    get "/users/:userID/working_times", WorkingTimeController, :retrieveAll
    get "/users/:userID/working_times/:id", WorkingTimeController, :retrieve
    put "/working_times/:id", WorkingTimeController, :update
    delete "/working_times/:id", WorkingTimeController, :delete

    post "/clocks", ClocksController, :create
    get "/users/:userID/clocks/:id", ClocksController, :retrieve
  end
end
