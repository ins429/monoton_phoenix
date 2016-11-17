defmodule Monoton.Post do
  use Monoton.Web, :model

  schema "posts" do
    field :link, :string
    field :body, :string
    field :tags, {:array, :string}

    belongs_to :user, Monoton.User

    timestamps
  end

  @required_fields ~w(link body user_id)
  @optional_fields ~w(tags)

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
