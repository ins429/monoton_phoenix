defmodule Monoton.Photo do
  use Monoton.Web, :model

  schema "photos" do
    field :name, :string, default: ""
    field :url, :string
    field :thumb_url, :string

    belongs_to :user, User

    timestamps
  end

  @required_fields ~w(user_id url)
  @optional_fields ~w(name)

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
