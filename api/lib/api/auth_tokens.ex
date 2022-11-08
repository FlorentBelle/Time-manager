defmodule Api.AuthTokens do
  use Ecto.Schema

  import Ecto.Changeset

  alias Api.User

  schema "auth_tokens" do
    field :token, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(auth_tokens, attrs) do
    auth_tokens
    |> cast(attrs, [:token])
    |> validate_required([:token])
  end
end
