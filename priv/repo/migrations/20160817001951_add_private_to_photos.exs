defmodule Monoton.Repo.Migrations.AddPrivateToPhotos do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :private, :boolean
    end
  end
end
