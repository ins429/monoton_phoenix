defmodule Monoton.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :name, :string
      add :photo, :string

      timestamps
    end
  end
end
