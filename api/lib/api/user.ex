defmodule Api.User do
  use Ecto.Schema
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
    |> validate_format(:email, ~r/@/)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

end
