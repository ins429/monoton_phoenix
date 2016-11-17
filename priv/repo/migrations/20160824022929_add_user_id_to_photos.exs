defmodule Monoton.Repo.Migrations.AddUserIdToPhotos do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :user_id, references(:users)
    end
  end
end
