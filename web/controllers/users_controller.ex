defmodule Monoton.UsersController do
  use Monoton.Web, :controller

  import Ecto.Changeset, only: [put_change: 3]

  alias Monoton.Repo
  alias Monoton.User

  def create(conn, _params) do
    changeset = User.changeset(%User{}, _params)

    if changeset.valid? do
      user = signup(changeset, Repo)
      json conn, changeset
    else
      json conn, %{error: "Unable to create account", changeset: changeset}
    end
  end

  def signup(changeset, repo) do
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> repo.insert()
  end

  def showme(conn, _params) do
    user = get_session(conn, :current_user)
    json conn, sanitize(user)
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def sanitize(data) when is_map(data) do
    data
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
    |> Map.delete(:password)
    |> Map.delete(:crypted_password)
  end
end

