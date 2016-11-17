defmodule Monoton.Photos.Create do
  alias Monoton.Repo
  alias Monoton.Photo
  alias Monoton.Uploader

  def call(params) do
    Repo.transaction(fn ->
      upload_photos(params)
      |> save!(params)
    end)
  end

  # defp save!({:ok}), do: []
  defp save!(photos, params) when is_list(photos) do
    Enum.map(photos, fn(photo_hash) ->
      params =
        Map.put(params, "hash", photo_hash)
        |> Map.update("tags", [], &transform_tags/1)
      Photo.changeset(%Photo{}, params)
      |> Repo.insert!
    end)
  end

  defp upload_photo(photo) do
    Uploader.upload!(photo)
  end

  defp upload_photos(%{"photos" => photos}) when is_list(photos) do
    Enum.map(photos, fn(photo) ->
      upload_photo(photo)
    end)
  end

  defp transform_tags(tags) when is_bitstring(tags) do
    String.split(tags, ",")
  end
  defp transform_tags(tags) when is_list(tags), do: tags
  defp transform_tags(_tags), do: []
end
