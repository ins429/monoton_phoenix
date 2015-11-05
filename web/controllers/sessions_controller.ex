defmodule Monoton.SessionsController do
  use Monoton.Web, :controller

  alias Monoton.Repo

  def create(conn, _params) do
    case Monoton.Session.login(_params, Repo) do
      {:ok, user} ->
        json conn, sanitize(user)
      :error ->
        json conn, %{error: "Wrong email or password"}
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    json conn, %{message: "Successfully logged out"}
  end

  def sanitize(data) when is_map(data) do
    data
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
    |> Map.delete(:crypted_password)
  end
end
