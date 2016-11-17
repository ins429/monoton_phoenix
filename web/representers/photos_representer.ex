defmodule Monoton.PhotosRepresenter do
  def call do
    %Representer.Collection{
      spec: Monoton.PhotoRepresenter
    }
  end
end
