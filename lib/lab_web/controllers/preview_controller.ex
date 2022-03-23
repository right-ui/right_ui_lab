defmodule LabWeb.PreviewController do
  use LabWeb, :controller

  def show(conn, %{"path" => path}) do
    template = "#{Enum.join(path, "/")}.html"
    render(conn, template)
  end
end
