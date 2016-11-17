defmodule Monoton.Uploader do
  alias Mogrify

  @base_url "https://s3-us-west-2.amazonaws.com/monoton/"
  @env Application.fetch_env!(:monoton, :env)

  # def upload!(plug_file) when @env == :dev do
  #   {:ok}
  # end
  def upload!(plug_file) do
    upload_to_s3(plug_file)
  end

  def upload_to_s3(plug_file) do
    photo_hash = hash <> file_extension(plug_file.filename)

    upload_original(plug_file, "photos/#{photo_hash}")
    upload_thumb(plug_file, "photos/thumb_#{photo_hash}")

    photo_hash
  end

  def upload_original(plug_file, upload_path) do
    put_object(plug_file, upload_path)
  end

  def upload_thumb(plug_file, upload_path) do
    plug_file
    |> convert_to_thumb_size
    |> put_object(upload_path)
  end

  defp put_object(file, upload_path) do
    raw = File.read!(file.path)
    size = get_file_size(file)
    results = ExAws.S3.put_object("monoton", upload_path, raw, [
      {:acl, :public_read},
      {:content_type, file.content_type},
      {:content_length, size}
    ]) |> ExAws.request
  end

  defp convert_to_thumb_size(plug_file) do
    Mogrify.open(plug_file.path)
    |> Mogrify.copy
    |> Mogrify.resize("200x200")
    |> Mogrify.save
    |> mogrify_to_plug(plug_file)
  end

  defp mogrify_to_plug(mogrify_file, plug_file) do
    Map.put(plug_file, :path, mogrify_file.path)
  end

  defp get_file_size(file) do
    stat = File.stat!(file.path)
    stat.size
    |> Integer.to_string
  end

  defp file_extension(filename) do
    ext = Path.extname(filename)
    case String.downcase(ext) do
      ".jpg"  -> ".jpg"
      ".jpeg" -> ".jpg"
      ".png"  -> ".png"
      ".gif"  -> ".gif"
    end
  end

  defp hash do
    Ecto.UUID.generate
  end
end
