defmodule Api.Roles do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Api.Roles
  alias Api.User
  alias Api.Repo

  @derive {Jason.Encoder, only: [:role_name, :id]}
  schema "roles" do
    field :role_name, :string
    timestamps()
  end

  @doc false
  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:role_name])
    |> validate_required([:role_name])
  end

end
