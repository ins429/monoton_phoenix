defmodule Monoton.Web.SessionsController do
  use Monoton.Web, :controller

  def new(conn, params) do
    render conn, "new.html",
      v: %Monoton.TemplateVariables{}
  end

  def create(conn, %{"user" => user_params}) do
    case Monoton.Session.login(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> redirect(to: pages_path(conn, :index))
    end
  end

  def destroy(conn, _) do
    conn
    |> delete_session(:current_user_id)
    |> redirect(to: pages_path(conn, :index))
  end
end
