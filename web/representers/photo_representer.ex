defmodule Monoton.PhotoRepresenter do
  def call do
    [
      :id,
      :name,
      :hash,
      :tags,
      thumb_url: &thumb_url/1,
      original_url: &original_url/1
    ]
  end

  defp thumb_url(photo) do
    "https://s3-us-west-2.amazonaws.com/monoton/photos/thumb_#{photo.hash}"
  end

  defp original_url(photo) do
    "https://s3-us-west-2.amazonaws.com/monoton/photos/#{photo.hash}"
  end
end
