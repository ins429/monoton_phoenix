defmodule Monoton.PhotoController do
  use Monoton.Web, :controller

  alias Monoton.Image
  alias Monoton.Photo
  alias Monoton.Repo

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, _params) do
    Image.store(_params["file"])
    
    json conn, %{"photos": "create"}
  end

  def show(conn, _params) do
    IO.puts _params[:id]
    json conn, sanitize(Repo.get!(Photo, _params["id"]))
  end

  def sanitize(data) when is_map(data) do
    data
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
  end
end
