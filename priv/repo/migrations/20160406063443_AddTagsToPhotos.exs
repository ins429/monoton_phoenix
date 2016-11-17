defmodule Monoton.Repo.Migrations.AddTagsToPhotos do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :tags, {:array, :string}
    end
  end
end
