defmodule Monoton.Repo.Migrations.AddUrlsToPhotos do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :thumb_url, :string
      add :original_url, :string
    end
  end
end
