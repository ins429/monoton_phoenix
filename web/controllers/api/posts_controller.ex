defmodule Monoton.Api.PostsController do
  use Monoton.Web, :controller

  alias Monoton.Post
  alias Monoton.Repo

  plug Monoton.UserAuth, require: :user

  def index(conn, params) do
    Monoton.Posts.Search.call(params)
    |> handle_result(conn)
  end

  def create(conn, params) do
    params
    |> Map.put("user_id", Plug.Conn.get_session(conn, :current_user_id))
    |> Monoton.Posts.Create.call
    |> handle_result(conn)
  end

  def update(conn, %{"id" => id} = params) do
    Monoton.Posts.Update.call(id, params)
    |> handle_result(conn)
  end

  def show(conn, %{"id" => id}) do
    Repo.get(Post, id)
    |> handle_result(conn)
  end

  def destroy(conn, %{"id" => id}) do
    Repo.get!(Post, id)
    |> Repo.delete!
    |> handle_result(conn)
  end

  defp handle_result({:ok, results}, conn) when is_list(results) do
    conn |> json(Representer.represent(results, Monoton.PostsRepresenter) |> wrap)
  end
  defp handle_result({:ok, result}, conn) do
    conn |> json(Representer.represent(result, Monoton.PostRepresenter) |> wrap)
  end
  defp handle_result(result, conn), do: handle_result({:ok, result}, conn)
end
