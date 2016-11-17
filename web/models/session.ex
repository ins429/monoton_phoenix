defmodule Monoton.Session do
  alias Monoton.User
  alias Monoton.Repo

  def login(user_params) do
    user = Repo.get_by(User, email: String.downcase(user_params["email"]))
    case authenticate(user, user_params["password"]) do
      true -> {:ok, user}
      _    -> {:error, "Wrong email or password"}
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user_id)
    if id, do: Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)
end
