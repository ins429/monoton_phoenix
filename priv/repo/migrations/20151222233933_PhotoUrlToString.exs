defmodule Monoton.Repo.Migrations.PhotoUrlToString do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      remove :urls
    end
  end
end
