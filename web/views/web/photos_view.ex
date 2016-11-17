defmodule Monoton.Web.PhotosView do
  use Monoton.Web, :view

  def tags_to_string(tags) when is_list(tags) do
    Enum.join(tags, ",")
  end
end
