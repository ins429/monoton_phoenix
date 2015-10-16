defmodule Monoton.UploadImage do
  use Arc.Definition
  use Arc.Actions.Store

  alias Monoton.UploadImage, as: UploadImage

  # Include ecto support (requires package arc_ecto installed):
  # use Arc.Ecto.Definition

  # To add a thumbnail version:
  @versions [:original, :thumb]

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100 -format png"}
  end

  def __storage, do: Arc.Storage.Local

  def filename(version,  file), do: "#{version}-#{file.file_name}"

  # Override the storage directory:
  # def storage_dir(version, {file, scope}) do
  #   "uploads/user/avatars/#{scope.id}"
  # end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end
end
