defmodule Monoton.UserAuth do
  def init(options) do
    options
  end

  def call(conn, options) do
    require_user_id(conn)
    conn
  end

  def require_user_id(conn) do
    mntn_user_id(conn) || raise Monoton.UserAuth.IdMissingException
  end

  def mntn_user_id(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id && user_id != "" do
      user_id
    else
      nil
    end
  end
end

defmodule Monoton.UserAuth.IdMissingException do
  defexception plug_status: 401, message: "user_id must be set"
end

