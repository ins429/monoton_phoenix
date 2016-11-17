defmodule Monoton.Repo.Migrations.AddHashColumnToPhotosTable do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :hash, :string
    end
  end
end
