defmodule Monoton.User do
  use Monoton.Web, :model

  schema "users" do
    field :name, :string
    field :phone, :string
    field :email, :string

    timestamps
  end

  @optional_fields ~w(name phone email)

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
