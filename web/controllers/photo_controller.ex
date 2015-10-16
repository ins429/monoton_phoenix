defmodule Monoton.PhotoController do
  use Monoton.Web, :controller

  alias Monoton.Image

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, _params) do
    Image.store(_params["file"])
    
    json conn, %{"photos": "create"}
  end
end
