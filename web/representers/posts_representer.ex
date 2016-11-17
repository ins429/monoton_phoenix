defmodule Monoton.PostsRepresenter do
  def call do
    %Representer.Collection{
      spec: Monoton.PostRepresenter
    }
  end
end
