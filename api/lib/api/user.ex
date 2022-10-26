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
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user(id), do: Repo.get(User, id)

  def get_user!(id), do: Repo.get!(User, id)

  def get_all_users(), do: Repo.all(User)

  def get_queried_users(email, username), do: Repo.one(from u in User, where: ilike(u.email, ^email), where: ilike(u.username, ^username))

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    user |> Repo.delete()
  end

end
