defmodule Monoton.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]

  @acl :public_read

  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250"}
  end

  # Override the persisted filenames:
  def filename(version, {file, _}) do
    "#{version}_#{file.file_name}"
  end

  # Override the storage directory:
  def storage_dir(version, {file, scope}) do
    "uploads/photos/#{scope.id}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end
end
