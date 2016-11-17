defmodule Monoton.Web.PhotosController do
  use Monoton.Web, :controller

  alias Monoton.Photo
  alias Monoton.Repo

  plug Monoton.UserAuth, require: :user

  def index(conn, params) do
    render conn, "index.html",
      v: %Monoton.TemplateVariables{
        photos: Monoton.Photos.Search.call(params) |> Representer.represent(Monoton.PhotosRepresenter),
        user: Monoton.Session.current_user(conn)
      }
  end

  def new(conn, params) do
    render conn, "new.html",
      v: %Monoton.TemplateVariables{
        user: Monoton.Session.current_user(conn)
      }
  end

  def create(conn, %{"photo" => photo_data}) do
    case Monoton.Photos.Create.call(photo_data) do
      {:ok, photo} ->
        conn
        |> redirect(to: photos_path(conn, :index))
      {:error, reason} ->
        put_flash(conn, :error, reason)
        |> render("edit.html")
    end
  end

  def edit(conn, %{"id" => id}) do
    render conn, "edit.html",
      v: %Monoton.TemplateVariables{
        user: Monoton.Session.current_user(conn),
        record: Repo.get(Photo, id) |> Representer.represent(Monoton.PhotoRepresenter)
      }
  end

  def update(conn, %{"id" => id, "photo" => photo_data}) do
    case Monoton.Photos.Update.call(id, photo_data) do
      {:ok, _photo} ->
        put_flash(conn, :info, "Photo ##{id} updated.")
        |> redirect(to: photos_path(conn, :index))
      {:error, reason} ->
        put_flash(conn, :error, reason)
        |> render("edit.html")
    end
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html",
      v: %Monoton.TemplateVariables{
        user: Monoton.Session.current_user(conn),
        record: Repo.get(Photo, id) |> Representer.represent(Monoton.PhotoRepresenter)
      }
  end
end
