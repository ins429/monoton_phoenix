defmodule Monoton.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :body, :string, null: false
      add :tags, {:array, :string}
      add :user_id, references(:users), null: false

      timestamps
    end
  end
end
