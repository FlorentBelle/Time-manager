defmodule Api.Roles do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Api.Roles
  alias Api.User
  alias Api.Repo

  @derive {Jason.Encoder, only: [:role_name, :id, :isAuthoriseAdmin, :isAuthoriseManager]}
  schema "roles" do
    field :role_name, :string
    field :isAuthoriseAdmin, :boolean
    field :isAuthoriseManager, :boolean

    #has_many :user_role, {"user_role", Api.UserRoles}

    timestamps()
  end

  @doc false
  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:role_name, :isAuthoriseAdmin, :isAuthoriseManager])
    |> validate_required([:role_name])
  end

end
