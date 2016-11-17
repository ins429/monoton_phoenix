defmodule Monoton.ControllerHelper do
  def wrap(%{"errors" => errors}) do
    %{
      "data" => nil,
      "errors" => errors
    }
  end

  def wrap(data) do
    %{
      "data" => data
    }
  end

  defp handle_result({:error, %Ecto.Changeset{} = changeset}, conn) do
    handle_result({:error, changeset.errors}, conn)
  end
  defp handle_result({:error, reasons}, conn) when is_list(reasons) do
    conn |> json(%{"errors" => reasons} |> wrap)
  end
  defp handle_result({:error, reason}, conn), do: handle_result({:error, [reason]}, conn)
end
