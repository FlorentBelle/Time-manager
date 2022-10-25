defmodule Api.WorkingTimes do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.WorkingTimes
  alias Api.Repo

  schema "workingtimes" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(working_times, attrs) do
    working_times
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end

  def get_working_time!(id), do: Repo.get!(WorkingTimes, id)

  def update_working_time(%WorkingTimes{} = user, attrs) do
    user
    |> WorkingTimes.changeset(attrs)
    |> Repo.update()
  end

end
