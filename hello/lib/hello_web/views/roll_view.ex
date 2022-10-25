defmodule HelloWeb.RollView do
  use HelloWeb, :view
  import Ecto.Query
  alias Hello.{Repo, User}
  defstruct [:id, :username, :email, :inserted_at, :updated_at]

  def render("getUserWithParams.json", %{id: nameemail}) do
    mail = nameemail["email"]
    myData = Repo.one(from u in User, where: ilike(u.email, ^mail))
    %{email: mail, username: nameemail["username"], data: myData}
  end 

  def render("getUserWithID.json", %{id: user_id}) do
    id = user_id["userID"]
    newId = String.to_integer(id)
    #idString = Integer.to_string(newId)
    myData = Repo.one(from u in User, where: u.id == ^newId)
    %{user: myData}
  end

  def render("getAllUsers.json", %{params: params}) do
    #myData = Repo.one(from u in User, where: ilike(u.email, ^mail), where: ilike(u.username, ^username))
    myData = Repo.all(User)
    %{user: myData}
  end

  #@derive {Jason.Encoder, only: [:id, :username, :mail]}
  def render("postUser.json", %{params: params}) do
    email = params["email"]
    username = params["username"]
    user = Repo.insert(%User{email: email, username: username})
    %{statut: "bien ajouté"}
  end

  def render("putUser.json", %{params: params}) do
    email = params["email"]
    username = params["username"]
    userID = params["userID"]
    #Repo.update()
    %{params: params}
  end

end
