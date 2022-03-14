defmodule LabWeb.PreviewLayoutController do
  use LabWeb, :controller

  def container(conn, assigns) do
    render(conn, "container.html")
  end
end
