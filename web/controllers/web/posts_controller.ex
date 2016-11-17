defmodule Monoton.Web.PostsController do
  use Monoton.Web, :controller

  alias Monoton.Post
  alias Monoton.Repo

  plug Monoton.UserAuth, require: :user

  def index(conn, params) do
    posts = Monoton.Posts.Search.call(params) |> Representer.represent(Monoton.PostsRepresenter)
    render conn, "index.html",
      v: %Monoton.TemplateVariables{
        posts: posts,
        user: Monoton.Session.current_user(conn)
      }
  end

  def new(conn, params) do
    render conn, "new.html",
      v: %Monoton.TemplateVariables{
        user: Monoton.Session.current_user(conn)
      }
  end

  def create(conn, %{"post" => post_data}) do
    result =
      post_data
      |> Map.put("user_id", Plug.Conn.get_session(conn, :current_user_id))
      |> Monoton.Posts.Create.call

    case result do
      {:ok, _result} ->
        redirect(conn, to: posts_path(conn, :index))
      {:error, changeset} ->
        put_flash(conn, :error, changeset.errors)
        |> render("new.html")
    end
  end

  def edit(conn, %{"id" => id}) do
    render conn, "edit.html",
      v: %Monoton.TemplateVariables{
        user: Monoton.Session.current_user(conn),
        record: Repo.get(Post, id)
      }
  end

  def update(conn, %{"id" => id, "post" => post_data}) do
    case Monoton.Posts.Update.call(id, post_data) do
      {:ok, _result} ->
        put_flash(conn, :info, "Post ##{id} updated.")
        |> redirect(to: posts_path(conn, :index))
      {:error, reason} ->
        put_flash(conn, :error, reason)
        |> render("edit.html")
    end
  end

  def destroy(conn, %{"id" => id}) do
    case Monoton.Posts.Destroy.call(id) do
      {:ok, _result} ->
        put_flash(conn, :info, "Post ##{id} deleted.")
        |> redirect(to: posts_path(conn, :index))
      {:error, changeset} ->
        put_flash(conn, :error, changeset.error)
        |> redirect(to: posts_path(conn, :index))
    end
  end
end
