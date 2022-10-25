defmodule ApiWeb.RollView do
  use ApiWeb, :view
  import Ecto.Query
  alias Api.{Repo, User, WorkingTimes}
  defstruct [:id, :username, :email, :inserted_at, :updated_at]

  def render("getUserWithID.json", %{id: user_id}) do
    id = user_id["userID"]
    newId = String.to_integer(id)
    #idString = Integer.to_string(newId)
    myData = Repo.one(from u in User, where: u.id == ^newId)
    %{user: myData}
  end

  def render("getUsers.json", %{params: params}) do
    myData = Repo.all(User)
    %{user: myData}
  end

  def render("getUserWithParams.json", %{params: params}) do
    username = params["username"]
    email = params["email"]
    firstQuery = from u in User, select: u.username
    firstQueryResults = Repo.all(firstQuery)
    secondQuery = from u in User, select: u.email
    secondQueryResults = Repo.all(secondQuery)
    results = firstQueryResults -- secondQueryResults
    # myData = Repo.one(from u in User, where: ilike(u.email, ^mail))
    %{user: results}
  end

  #@derive {Jason.Encoder, only: [:id, :username, :mail]}
  def render("postUser.json", %{params: params}) do
    email = params["email"]
    username = params["username"]
    user = Repo.insert(%User{email: email, username: username})
    %{statut: "bien ajouté"}
  end

  #@derive {Jason.Encoder, only: [:id, :username, :mail]}
  def render("postWorkingTime.json", %{params: params}) do
    {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(params["end"])
    end_ = DateTime.truncate(dt_struct, :second)
    {:ok, dt_struct, utc_offset} = DateTime.from_iso8601(params["start"])
    start = DateTime.truncate(dt_struct, :second)
    userId = params["userId"]
    workingTimeId = Repo.insert(%WorkingTimes{end: end_, start: start, user: userId})
    %{statut: "bien ajouté"}
  end

  def render("putUser.json", %{params: params}) do
    email = params["email"]
    username = params["username"]
    userID = params["userID"]
    %{params: params}
  end

  def render("putWorkingTime.json", %{params: params}) do
    end_ = params["end"]
    start = params["start"]
    userID = params["userID"]
    %{params: params}
  end

end
