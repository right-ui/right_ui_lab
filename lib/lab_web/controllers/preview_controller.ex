defmodule LabWeb.PreviewController do
  use LabWeb, :controller

  def show(conn, %{"path" => path}) do
    template = "#{Enum.join(path, "/")}.html"

    conn
    |> assign(:title, Enum.join(path, " / "))
    |> put_layout("preview.html")
    |> render(template)
  end
end
