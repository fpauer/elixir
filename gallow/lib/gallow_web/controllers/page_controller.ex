defmodule GallowWeb.PageController do
  use GallowWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
