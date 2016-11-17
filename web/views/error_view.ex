defmodule Monoton.ErrorView do
  use Monoton.Web, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Server internal error"
  end

  def render(file, assigns) do
    error_reason =
      if Exception.exception?(assigns[:reason]) do
        Exception.message(assigns[:reason])
      else
        inspect assigns[:reason]
      end

    if String.match?(file, ~r/json/) do
      %{data: %{}, errors: [error_reason]}
    else
      error_reason
    end
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
