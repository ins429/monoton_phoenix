defmodule Monoton.Photos.Create do
  # alias Ecto.Model, as: EM
  # alias Monoton.Repo
  # alias Monoton.Photo, as: Model
  # alias Monoton.Image

  # def call(%{"user_id" => user_id, "monoton_photo" => params}) do
  #   set_filename(params, "monoton_photo")
  #   |> Map.merge(%{"user_id" => user_id})
  #   |> set_file_size
  #   |> set_photo_hash
  #   |> set_content_type
  #   |> create_photo!
  #   |> upload_photo! params["data"]
  # end

  # defp create_photo!(params) do
  #   Model.changeset(%Model{}, params)
  #   |> Repo.insert!
  # end

  # defp set_photo_hash(params) do
  #   photo_hash = String.split(params["data"].filename, ~r(\.png)) |> List.first
  #   Map.merge(params, %{"photo_hash" => photo_hash})
  # end

  # defp set_filename(params, identifier) do
  #   pieces = [
  #     "appliances",
  #     "#{identifier}",
  #     "versions",
  #     "original",
  #     params["data"].filename
  #   ]

  #   url = Path.join(pieces)

  #   Map.merge(params, %{"url" => url})
  # end

  # defp set_file_size(params) do
  #   file_size = case File.read(params["data"].path) do
  #     {:ok, file} ->
  #       byte_size(file)
  #     _ -> 0
  #   end

  #   Map.merge(params, %{"file_size" => file_size})
  # end

  # # defp upload_photo!(file) do
  # #   Image.store(_params["file"])
  # # end

  # defp set_content_type(params) do
  #   params
  #   |> Map.merge(%{"content_type" => params["data"].content_type})
  # end
end
