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

  pipeline :auth do
    plug ApiWeb.JWTAuthPlug
  end

  scope "/", ApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ApiWeb do
    pipe_through :auth

    delete "/logout", AuthController, :delete

    get "/users", UserController, :retrieveAll
    get "/users/:userID", UserController, :retrieve
    put "/users/:userID", UserController, :update
    delete "/users/:userID", UserController, :delete

    post "/workingtimes/:userID", WorkingTimeController, :create
    get "/workingtimesTeams/:teamID", WorkingTimeController, :retrieveAllWithTime
    get "/workingtimes/:userID", WorkingTimeController, :retrieveAll
    get "/users/:userID/workingtimes/:id", WorkingTimeController, :retrieve
    put "/workingtimes/:id", WorkingTimeController, :update
    delete "/workingtimes/:id", WorkingTimeController, :delete

    post "/clocks", ClocksController, :create
    put "/clocks/:id", ClocksController, :update
    get "/clocks/:userID", ClocksController, :retrieve

    get "/roles",  RolesController, :retrieve
    post "/roles", RolesController, :create
    get "/roles/:roleID", RolesController, :retrievedroits

    get "/teams",  TeamsController, :retrieve
    get "/teams/:userID",  TeamsController, :retrievewithid
    post "/teams/:userID", TeamsController, :create

    get "/teamMember/:teamID", TeamMemberController, :retrieve
    post "/teamMember/:userID/:teamID", TeamMemberController, :addteammember
    delete "/teamMember/:userID/:teamID", TeamMemberController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api/auth", ApiWeb do
    pipe_through :api

    post "/register", AuthController, :register
    post "/login", AuthController, :login
  end
end
