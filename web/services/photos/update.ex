defmodule Monoton.Photos.Update do
  alias Monoton.Repo
  alias Monoton.Photo
  alias Monoton.Uploader

  def call(id, params) do
    params
    |> upload_photo
    |> prepare_photo(id)
    |> save
  end

  defp prepare_photo(params, id) do
    Repo.get(Photo, id)
    |> Photo.changeset(params)
  end

  defp save(changeset) do
    changeset
    |> Repo.update
  end

  defp upload_photo(%{"photo" => photo} = params) do
    hash = Uploader.upload!(photo)
    Map.put(params, "hash", hash)
  end

  defp upload_photo(params), do: params
end
