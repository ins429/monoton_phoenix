defmodule Monoton.Photo do
  use Monoton.Web, :model
  use Arc.Ecto.Model

  schema "photos" do
    field :name, :string
    # field :description, :string
    # field :user_id, :integer
    # field :tags, {:array, :string}
    field :photo, Monoton.Image.Type

    # belongs_to :user, User

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w()

  @required_file_fields ~w()
  @optional_file_fields ~w(photo)

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end
end
