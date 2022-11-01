defmodule Api.Member do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Api.Member
  alias Api.Teams
  alias Api.User
  alias Api.Repo

  @derive {Jason.Encoder, only: [:team, :user, :id]}
  schema "team_member" do
    field :team, :id
    field :user, :id
  end

  def changeset(member, attrs) do
    member
    |> cast(attrs, [:user, :team])
  end

end
