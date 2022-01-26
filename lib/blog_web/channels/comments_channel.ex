defmodule BlogWeb.CommentsChannel do
  use BlogWeb, :channel

  def join(name, _payload, socket), do: {:ok, %{name: "It's working!"}, socket}

  def handle_id() do

  end
end
