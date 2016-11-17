defmodule Monoton.Posts.Search do
  alias Monoton.Repo
  alias Monoton.Post

  import Ecto.Query

  def call(params) do
    filter(params)
    |> sort(params)
    |> fetch
  end

  defp filter(%{"tags" => ""}), do: filter(%{})
  defp filter(%{"tags" => tags}) do
    from p in Post,
    where: ^"#{tags}" in p.tags
  end
  defp filter(_params), do: from p in Post

  defp sort(query, _params) do
    from p in query,
    order_by: [desc: p.inserted_at]
  end
  # defp sort(_params), do: from p in Post

  defp fetch(query), do: Repo.all(query)
end
