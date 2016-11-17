defmodule Monoton.Posts.Create do
  alias Monoton.Repo
  alias Monoton.Post
  alias Monoton.Uploader

  def call(params) do
    params
    |> prepare_post
    |> save
  end

  # defp save!({:ok}), do: []
  defp save(post_changeset) do
    post_changeset
    |> Repo.insert
  end

  defp prepare_post(params) do
    params =
      Map.update(params, "tags", [], &transform_tags/1)
    Post.changeset(%Post{}, params)
  end

  defp transform_tags(tags) when is_bitstring(tags) do
    String.split(tags, ",")
  end
  defp transform_tags(tags) when is_list(tags), do: tags
  defp transform_tags(_tags), do: []
end
