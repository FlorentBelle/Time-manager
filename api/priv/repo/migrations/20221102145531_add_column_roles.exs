defmodule Api.Repo.Migrations.AddColumnRoles do
  use Ecto.Migration

  def change do
    alter table("roles") do
      add :isAuthoriseAdmin, :boolean
      add :isAuthoriseManager, :boolean
    end
  end
end
