defmodule Api.User do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  alias Api.User
  alias Api.Repo

  @derive {Jason.Encoder, only: [:email, :username, :id, :inserted_at, :updated_at]}
  schema "users" do
    field :email, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_length(:username, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

end
