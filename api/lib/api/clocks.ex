defmodule Api.Clocks do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Api.Clocks
  alias Api.Repo

  @derive {Jason.Encoder, only: [:id, :status, :time, :user]}
  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :utc_datetime
    belongs_to :user, Api.User

    timestamps()
  end

  @doc false
  def changeset(clocks, attrs) do
    clocks
    |> cast(attrs, [:time, :status])
    |> validate_required([:time, :status])
  end

  def create_clock(attrs \\ %{}) do
    %Clocks{}
    |> Clocks.changeset(attrs)
    |> Repo.insert()
  end

  def get_clock(id), do: Repo.get(Clocks, id)

  def get_clock!(id), do: Repo.get!(Clocks, id)
end
