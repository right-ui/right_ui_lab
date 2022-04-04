defmodule LabWeb.PreviewController do
  use LabWeb, :controller

  def index(conn, _params) do
    render(conn)
  end

  def show(conn, %{"path" => path}) do
    template = "#{Enum.join(path, "/")}.html"

    changeset = create_changeset_for_previewing_form()

    conn
    |> assign(:title, Enum.join(path, " / "))
    |> put_layout("preview.html")
    |> render(template, changeset: changeset)
  end

  defp create_changeset_for_previewing_form() do
    data = %{}
    types = %{name: :string, email: :string, age: :integer}
    params = %{name: "Charlie Brown", email: "charlie@example.com"}

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_required(:age)
    |> Map.put(:action, :validate)
  end
end
