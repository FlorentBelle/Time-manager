defmodule HelloWeb.RollView do
  use HelloWeb, :view
  import Ecto.Query
  #import Ecto.DateTime
  #import Timex.Ecto.DateTime
  import Elixir.DateTime
  alias Hello.{Repo, User, Clocks, WorkingTimes}
  defstruct [:id, :username, :email, :inserted_at, :updated_at]

  def render("getUserWithID.json", %{id: user_id}) do
    id = user_id["userID"]
    newId = String.to_integer(id)
    #idString = Integer.to_string(newId)
    myData = Repo.one(from u in User, where: u.id == ^newId)
    %{user: myData}
  end

  def render("getAllUsers.json", %{params: params}) do
    email = params["email"]
    username = params["username"]

    if (email === nil && username === nil) do
      user = Repo.all(User)
      %{user: user}
    else
      if (email === nil || username === nil) do
          %{statut: "403", commentaire: "pas assez d'argument renseignés"}
      else
        user = Repo.one(from u in User, where: ilike(u.email, ^email), where: ilike(u.username, ^username))
        if (user === nil) do
          %{statut: "403", commentaire: "pas d'utilisateur trouvé"}
        else
          %{statut: "200", commentaire: "utilisateur trouvé", user: user}
        end
      end
    end
    
  end

  #@derive {Jason.Encoder, only: [:id, :username, :mail]}
  def render("postUser.json", %{params: params}) do
    email = params["email"]
    username = params["username"]
    isUserEmail = Repo.one(from u in User, where: ilike(u.email, ^email))
    isUserUsername = Repo.one(from u in User, where: ilike(u.username, ^username))
    if (isUserEmail === nil && isUserUsername === nil) do
      Repo.insert(%User{email: email, username: username})
      %{statut: "200", commentaire: "Utilisateur bien ajouté"}
    else
      %{statut: "403", commentaire: "Un utilisateur est déja enregistré avec les identifiants dans la base de donnée"}
    end
  end

  def render("deleteUser.json", %{params: params}) do
    userID = params["userID"]
    newId = String.to_integer(userID)
    user = Repo.one(from u in User, where: u.id == ^newId)

    #workingtime = Repo.all(from w in WorkingTimes, where: w.user == ^userID)
    if (user !== nil) do
      Repo.delete(user)
      %{statut: "200", commentaire: "Utilisateur bien supprimé"}
    else
      %{statut: "403", commentaire: "Pas d'utilisateur trouvé avec l'id rensigné"}
    end
  end

  def render("putUser.json", %{params: params}) do
    email = params["email"]
    username = params["username"]
    userID = params["userID"]

    user = User |> Repo.get_by(id: userID)
    changeset = User.changeset(user, %{username: username, email: email})
    Repo.update!(changeset)
    %{params: params, user: user}
  end

  def render("getAllWorktimes.json", %{params: params}) do
    start = params["start"]
    fin = params["end"]
    userID = params["userID"]

    if (start === nil || fin === nil) do
      #%{statut: "403", commentaire: "les paramètres ne sont pas correct"}
      IO.puts("hello world")

      if (start !== nil) do
        workingtimes = Repo.all(from u in WorkingTimes, where: u.user == ^userID, where: u.start >= ^start) 
        %{workingtimes: workingtimes}
      else
        if (fin !== nil) do
            workingtimes = Repo.all(from u in WorkingTimes, where: u.user == ^userID, where: u.end <= ^fin) 
            %{workingtimes: workingtimes}
        end
      end
    else
      myData = Repo.all(from u in WorkingTimes, where: u.user == ^userID, where: u.start >= ^start, where: u.end <= ^fin) 
      %{params: params, start: start, fin: fin, userID: userID, workingtimes: myData}
    end
  end

  def render("getWorktimesByID.json", %{params: params}) do
    id = params["id"]
    userID = params["userID"]
    myData = Repo.one(from u in WorkingTimes, where: u.user == ^userID, where: u.id == ^id)
    if (myData !== nil) do
      %{statut: "200", WorkingTime: myData}
    else
      %{statut: "403", WorkingTime: "pas de workingtimes trouvé pour l'ID"}
    end
  end

  def render("postWorkingTimes.json", %{params: params}) do
    userID = params["id"]
    start = params["start"]
    fin = params["end"]

    #myData = Repo.insert(%WorkingTimes{user: userID, start: start, end: fin})
    %{userID: start}
  end

  def render("deleteWorkingTime.json", %{params: params}) do
    id = params["id"]
    newId = String.to_integer(id)
    workingtime = Repo.one(from u in WorkingTimes, where: u.id == ^newId)
    if (workingtime === nil) do
      %{statut: "403", commentaire: "403 : pas de working time avec l'id sélectionner trouvé", workingID: id}
    else
      Repo.delete(workingtime)
      %{statut: "200", commentaire: "200 : suppression du working time supprimé", workingtimeID: id}
    end
  end

end
