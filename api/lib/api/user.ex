defmodule Api.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Api.User
  alias Api.AuthTokens
  alias Api.Repo

  @derive {Jason.Encoder, only: [:id, :email, :username, :role_id], except: [:__meta__, :inserted_at, :updated_at, :auth_tokens]}
  schema "users" do
    field :email, :string
    field :username, :string
    field :role_id, :id
    field :password, :string

    has_many :auth_tokens, AuthTokens

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role_id, :password])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 2)
    |> validate_length(:password, min: 8, max: 30)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> hash_password
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{ valid?: true, changes: %{ password: password } } -> put_change(changeset, :password, Pbkdf2.hash_pwd_salt(password))
      _ -> changeset
    end
  end

end
