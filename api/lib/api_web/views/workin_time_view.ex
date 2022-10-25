defmodule ApiWeb.WorkingTimeView do
  use ApiWeb, :view

  import Ecto.Query

  alias Api.{Repo, User, Clocks, WorkingTimes}


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

  def render("getAllWorktimes.json", %{params: params}) do
    start = params["start"]
    fin = params["end"]
    userID = params["userID"]

    if (start === nil || fin === nil) do
      #%{statut: "403", commentaire: "les paramètres ne sont pas correct"}
      
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

  def render("putWorkingTime.json", %{params: params}) do
    end_ = params["end"]
    start = params["start"]
    userID = params["userID"]
    %{params: params}
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
