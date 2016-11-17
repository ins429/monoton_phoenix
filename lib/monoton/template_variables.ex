defmodule Monoton.TemplateVariables do
  defstruct user: %Monoton.User{},
            posts: [%Monoton.Post{}],
            photos: [%Monoton.Photo{}],
            record: nil
end
