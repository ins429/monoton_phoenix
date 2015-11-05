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

    get "/", PagesController, :index
    get "/photos", PhotosController, :index
    get "/photos/:id", PhotosController, :show
    post "/photos", PhotosController, :create
    put "/photos/:id", PhotosController, :update

    post "/login", SessionsController, :create
    post "/signup", UsersController, :create
    delete "/logout", SessionsController, :delete
    get "/showme", UsersController, :showme
  end

  # Other scopes may use custom stacks.
  # scope "/api", Monoton do
  #   pipe_through :api
  # end
end
