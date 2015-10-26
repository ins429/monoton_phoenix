defmodule Monoton.PhotoController do
  use Monoton.Web, :controller

  alias Monoton.Image
  alias Monoton.Photo
  alias Monoton.Repo

  def index(conn, _params) do
    photos = Photo
    |> Repo.all
    |> Enum.map(&sanitize/1)

    json conn, photos
  end

  def create(conn, _params) do
    photo = Repo.insert!(%Photo{})
    changeset = Photo.changeset(photo, %{photo: _params["image"]})
    Repo.update!(changeset)

    json conn, sanitize(changeset)
  end

  def update(conn, _params) do
    photo = Repo.get!(Photo, _params["id"])
    changeset = Photo.changeset(photo, _params)
    Repo.update!(changeset)

    json conn, sanitize(changeset)
  end

  def show(conn, _params) do
    IO.puts _params[:id]
    json conn, sanitize(Repo.get!(Photo, _params["id"]))
  end

  def sanitize(data) when is_map(data) do
    urls = Image.urls(data.photo)
    photo_with_urls = Map.put(data.photo, :urls, urls)
    data
    |> Map.put(:photo, photo_with_urls)
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
  end
end
