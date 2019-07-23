defmodule GallowWeb.AbcController do
  use GallowWeb, :controller

  def index(conn, _params) do
    render conn, "xyz.html"
  end
end
