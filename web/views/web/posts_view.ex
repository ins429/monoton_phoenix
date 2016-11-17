defmodule Monoton.Web.PostsView do
  use Monoton.Web, :view

  def embed_link(link) do
    cond do
      String.contains?(link, "streamable") ->
        String.replace(link, "streamable.com/", "streamable.com/e/")
      String.contains?(link, "streamable") ->
        String.replace(link, "streamable.com/", "streamable.com/e/")
      true ->
        link
    end
  end

  def tags_to_string(tags) when is_list(tags) do
    Enum.join(tags, ",")
  end
end
