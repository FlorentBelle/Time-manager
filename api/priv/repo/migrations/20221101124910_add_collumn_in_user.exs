defmodule Api.Repo.Migrations.AddCollumnInUser do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :role_id, references(:roles)
    end

    # if you want the index -and why not wanting it? ;)
    # pls note this is after the `alter` macro, and inside the `change` callback def
    create index(:users, [:role_id])
  end
end
