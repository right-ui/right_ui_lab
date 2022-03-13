defmodule LabWeb.PreviewComponent do
  use RightUI, :component

  def preview(assigns) do
    assigns =
      assigns
      |> attr(:title, :string, required: true)

    ~H"""
    <div class="preview_component">
      <div class="flex items-center mb-3 whitespace-nowrap">
        <h3 class="font-medium text-gray-900 truncate"><%= @title %></h3>
      </div>
      <div class="bg-gray-500 rounded-lg ring-1 ring-gray-900 ring-opacity-5 overflow-hidden">
        <div class="boost-ui-preview_container relative w-full pr-4">
          <%= render_slot(@inner_block) %>

          <div
            class="preview_component_handler
          sr-only sm:not-sr-only
          sm:absolute sm:inset-y-0 sm:right-0 sm:w-4
          sm:flex sm:items-center
          sm:border-l sm:bg-gray-100 cursor-[ew-resize]"
          >
            <svg
              aria-hidden="true"
              class="h-4 w-4 text-gray-600 pointer-events-none"
              fill="currentColor"
              viewBox="0 0 24 24"
            >
              <path d="M8 5h2v14H8zM14 5h2v14h-2z"></path>
            </svg>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def box(assigns) do
    assigns =
      assigns
      |> attr(:class, :string)
      |> attr(:extra, :rest, exclude: [:class])

    ~H"""
    <svg
      class={
        merge_class(
          "border-2 border-dashed border-gray-300 bg-white h-64 w-full text-gray-200",
          @class
        )
      }
      preserveAspectRatio="none"
      stroke="currentColor"
      fill="none"
      viewBox="0 0 200 200"
      aria-hidden="true"
    >
      <path vector-effect="non-scaling-stroke" stroke-width="2" d="M0 0l200 200M0 200L200 0"></path>
    </svg>
    """
  end
end
