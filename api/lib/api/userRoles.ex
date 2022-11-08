defmodule Api.UserRoles do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  #@primary_key false
  @derive {Jason.Encoder, only: [:user, :role]}
  schema "user_role" do
    belongs_to :user, Api.User
    belongs_to :role, Api.Roles
  end


end
