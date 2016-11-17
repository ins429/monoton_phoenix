defmodule Monoton.Posts.Update do
  alias Monoton.Repo
  alias Monoton.Post
  alias Monoton.Uploader

  def call(id, params) do
    params =
      Map.update(params, "tags", [], &transform_tags/1)
    prepare_post(id, params)
    |> save
  end

  # defp save({:ok}), do: []
  defp save(post_changeset) do
    post_changeset
    |> Repo.update
  end

  defp prepare_post(id, params) do
    Repo.get!(Post, id)
    |> Repo.preload(:user)
    |> Post.changeset(params)
  end

  defp transform_tags(tags) when is_bitstring(tags) do
    String.split(tags, ",")
  end
  defp transform_tags(tags) when is_list(tags), do: tags
  defp transform_tags(_tags), do: []
end
