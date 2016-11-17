defmodule Monoton.Posts.Destroy do
  alias Monoton.Repo
  alias Monoton.Post
  alias Monoton.Uploader

  def call(id) do
    get(id)
    |> delete
  end

  defp get(id) do
    Repo.get(Post, id)
  end

  defp delete(nil), do: {:error, "Post not found."}
  defp delete(post), do: Repo.delete(post)
end
