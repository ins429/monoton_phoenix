defmodule Monoton.Endpoint do
  use Phoenix.Endpoint, otp_app: :monoton

  # def call(conn, opts) do
  #   try do
  #     super(conn, opts)
  #   catch
  #     kind, reason ->
  #       conn = Phoenix.Controller.accepts(conn, ["html", "json"])
  #       status = status(kind, reason)
  #       format = conn.private[:phoenix_format]

  #       response = Monoton.ErrorView.render("#{status}.#{format}", %{conn: conn, kind: kind, reason: reason})
  #       response_function(format).(Plug.Conn.put_status(conn, status), response)
  #   end
  # end

  # defp response_function("json"), do: &Phoenix.Controller.json/2
  # defp response_function("html"), do: &Phoenix.Controller.html/2

  # defp status(:error, error), do: Plug.Exception.status(error)
  # defp status(:throw, _throw), do: 500
  # defp status(:exit, _exit), do: 500

  socket "/socket", Monoton.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :monoton, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_monoton_key",
    signing_salt: "7R/eaEwN"

  plug Monoton.Router
end
