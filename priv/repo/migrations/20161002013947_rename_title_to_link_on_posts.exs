defmodule Monoton.Repo.Migrations.RenameTitleToLinkOnPosts do
  use Ecto.Migration

  def change do
    rename table(:posts), :title, to: :link
  end
end
