defmodule Tempo.Repo.Migrations.CreateHabits do
  use Ecto.Migration

  def change do
    create table(:habits) do
      add :name, :string
      add :iterations, :integer

      timestamps()
    end

  end
end
