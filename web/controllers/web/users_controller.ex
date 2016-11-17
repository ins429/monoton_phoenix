defmodule Monoton.Web.UsersController do
  use Monoton.Web, :controller

  import Ecto.Changeset, only: [put_change: 3]

  alias Monoton.Repo
  alias Monoton.User

  def create(conn, params) do
    User.changeset(%User{}, params)
    |> signup
    |> handle_result(conn)
  end

  def signup(changeset) do
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> Repo.insert
  end

  def showme(conn, _params) do
    u = conn
    |> Monoton.Session.current_user
    |> handle_result(conn)
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def sanitize(data) when is_nil(data) do
    nil
  end

  defp handle_result({:ok, result}, conn) do
    conn |> json(Representer.represent(result, Monoton.UserRepresenter) |> wrap)
  end
  defp handle_result(%Monoton.User{} = user, conn), do: handle_result({:ok, user}, conn)
end
