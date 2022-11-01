defmodule Api.Teams do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Api.Teams
  alias Api.User
  alias Api.Repo

  @derive {Jason.Encoder, only: [:team_name, :user, :id]}
  schema "teams" do
    field :team_name, :string
    field :user, :id
  end

  def changeset(teams, attrs) do
    teams
    |> cast(attrs, [:team_name, :user])
    |> validate_required([:team_name])
  end

end
