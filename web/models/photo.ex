defmodule Monoton.Photo do
  use Monoton.Web, :model

  schema "photos" do
    field :name, :string
    field :hash, :string
    field :private, :boolean, default: false
    field :tags, {:array, :string}, default: []

    belongs_to :user, Monoton.User

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w(tags name hash private)

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def fields, do: Enum.map(@required_fields ++ @optional_fields ++ ["id"], &String.to_atom/1)
end
