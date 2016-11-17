defmodule Monoton.Api.PhotosController do
  use Monoton.Web, :controller

  alias Monoton.Photo
  alias Monoton.Repo

  plug Monoton.UserAuth, require: :user

  def index(conn, params) do
    Monoton.Photos.Search.call(params)
    |> handle_result(conn)
  end

  def create(conn, params) do
    Monoton.Photos.Create.call(params)
    |> handle_result(conn)
  end

  def update(conn, %{"id" => id} = params) do
    Monoton.Photos.Update.call(id, params)
    |> handle_result(conn)
  end

  def show(conn, %{"id" => id}) do
    Repo.get(Photo, id)
    |> handle_result(conn)
  end

  def destroy(conn, %{"id" => id}) do
    Repo.get!(Photo, id)
    |> Repo.delete!
    |> handle_result(conn)
  end

  defp handle_result({:ok, results}, conn) when is_list(results) do
    conn |> json(Representer.represent(results, Monoton.PhotosRepresenter) |> wrap)
  end
  defp handle_result({:ok, result}, conn) do
    conn |> json(Representer.represent(result, Monoton.PhotoRepresenter) |> wrap)
  end
  defp handle_result(result, conn), do: handle_result({:ok, result}, conn)
end
