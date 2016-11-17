defmodule Monoton.Repo.Migrations.UpdatePhoto do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :urls, :map
    end
  end
end
