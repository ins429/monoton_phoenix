defmodule Monoton.Web.PagesController do
  use Monoton.Web, :controller

  def index(conn, params) do
    render conn, "index.html",
      v: %Monoton.TemplateVariables{
        user: Monoton.Session.current_user(conn)
      }
  end
end
