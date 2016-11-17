defmodule Monoton.PostRepresenter do
  def call do
    [
      :id,
      :link,
      :body,
      :tags,
      :inserted_at,
      :updated_at
    ]
  end
end
