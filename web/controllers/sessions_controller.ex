defmodule Monoton.SessionsController do
  use Monoton.Web, :controller

  def create(conn, %{"session" => session_params}) do
    case Monoton.Session.login(session_params, Blog.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end
end
