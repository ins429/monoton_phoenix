defmodule Monoton.Router do
  use Monoton.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Monoton do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/photos", PhotoController, :index
    get "/photos/:id", PhotoController, :show
    post "/photos", PhotoController, :create
    put "/photos/:id", PhotoController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", Monoton do
  #   pipe_through :api
  # end
end
