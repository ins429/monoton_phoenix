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
    plug :fetch_session
  end

  scope "/api", Monoton do
    pipe_through :api

    # get "/photos", PhotosController, :index
    # get "/photos/:id", PhotosController, :show
    # post "/photos", PhotosController, :create
    # put "/photos/:id", PhotosController, :update
    # delete "/photos/:id", PhotosController, :destroy

    # get "/posts", PostsController, :index
    # get "/posts/:id", PostsController, :show
    # post "/posts", PostsController, :create
    # put "/posts/:id", PostsController, :update
    # delete "/posts/:id", PostsController, :destroy

    # post "/login", SessionsController, :create
    # post "/signup", UsersController, :create
    # delete "/logout", SessionsController, :delete
    get "/showme", UsersController, :showme
  end

  scope "/", Monoton.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PagesController, :index

    get "/photos", PhotosController, :index
    get "/photos/new", PhotosController, :new
    post "/photos", PhotosController, :create
    get "/photos/:id", PhotosController, :show
    get "/photos/:id/edit", PhotosController, :edit
    put "/photos/:id", PhotosController, :update

    get "/posts", PostsController, :index
    get "/posts/new", PostsController, :new
    get "/posts/:id/edit", PostsController, :edit
    put "/posts/:id", PostsController, :update
    post "/posts", PostsController, :create
    delete "/posts/:id", PostsController, :destroy

    get "/login", SessionsController, :new
    post "/login", SessionsController, :create
    get "/logout", SessionsController, :destroy
  end

  # Other scopes may use custom stacks.
  # scope "/api", Monoton do
  #   pipe_through :api
  # end
end
