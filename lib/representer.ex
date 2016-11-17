defmodule Representer do
  defmodule Collection do
    defstruct spec: []
  end

  def represent(input_collection, representer = %Collection{}) when is_list(input_collection) do
    input_collection
    |> Enum.map(fn item ->
      represent(item, representer.spec)
    end)
  end
  def represent(input_map, representer) when is_list(representer) do
    representer
    |> Enum.reduce(%{}, fn key, output_map ->
      represent_key(output_map, input_map, key)
    end)
  end
  def represent(input, _representer) when is_nil(input), do: nil
  def represent({:ok, input}, representer), do: represent(input, representer)
  def represent({:error, reason}, _representer), do: %{"errors" => [reason]}
  def represent(input, representer), do: represent(input, representer.call)

  @shortdoc "Represent a single key from `input_map`, and append to `output_map`"
  def represent_key(output_map, input_map, key) when is_atom(key) do
    if Map.has_key?(input_map, key) do
      value = Map.get(input_map, key)
      output_map |> Map.put(key, value)
    else
      output_map
    end
  end
  def represent_key(output_map, input_map, key) when is_list(key) do
    child_representer = key
    output_map |> Map.merge(represent(input_map, child_representer))
  end
  def represent_key(output_map, input_map, {key, getter}) when is_function(getter, 1) do
    output_map |> Map.put(key, getter.(input_map))
  end
  def represent_key(output_map, input_map, key) when is_tuple(key) do
    {child_key, child_representer} = key
    child = input_map[child_key]
    output_map |> Map.put(child_key, represent(child, child_representer))
  end
end
