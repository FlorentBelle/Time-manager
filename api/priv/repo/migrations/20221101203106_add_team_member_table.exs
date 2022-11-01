defmodule Api.Repo.Migrations.AddTeamMemberTable do
  use Ecto.Migration

  def change do
    create table(:team_member) do
      add :team, references(:teams)
      add :user, references(:users)

    end
    create index(:team_member, [:team, :user])
  end
end
