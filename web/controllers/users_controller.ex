defmodule Monoton.UsersController do
  use Monoton.Web, :controller

  import Ecto.Changeset, only: [put_change: 3]

  alias Monoton.User

  def create(conn, %{"user" => user_params}) do
      changeset = User.changeset(%User{}, user_params)

      if changeset.valid? do
        user = signup(changeset, Monoton.Repo)
        conn
        |> put_flash(:info, "Your account was created")
        |> redirect(to: "/")
      else
        conn
        |> put_flash(:info, "Unable to create account")
        |> render("new.html", changeset: changeset)
      end
  end

  def signup(changeset, repo) do
    changeset
    |> put_change(:crypted_password, hashed_password(changeset.params["password"]))
    |> repo.insert()
  end

  def login(conn, %{"session" => session_params}) do
    case Monoton.Session.login(session_params, Monoton.Repo) do
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

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end

