defmodule Api.WorkingTimes do
  use Ecto.Schema
  import Ecto.Changeset

  alias Api.WorkingTimes
  alias Api.Repo

  @derive {Jason.Encoder, only: [:id, :start, :end, :user]}
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

end
