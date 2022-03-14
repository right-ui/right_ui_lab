defmodule LabWeb.PreviewComponent do
  use RightUI, :component
  alias LabWeb.Router.Helpers, as: Routes

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
        <div class="preview_component_container relative w-full pr-4">
          <iframe
            title={@title}
            aria-label={@title}
            class="preview_component_iframe w-full rounded-lg overflow-hidden sm:rounded-r-none"
            srcdoc={to_srcdoc(assigns)}
          >
          </iframe>
          <!--
               The mask for iframe.

               When using iframe, there are two browsing contexts:
               + one for current document
               + one for the iframe

               Suppose that a `pointermove` event listener is defined in current document, when pointer
               is moving on the iframe, the defined event listener won't be trigged. Because the browsing
               contexts are different.

               In order to make `pointermove` event listener works as expected. There's a possible solution:
               1. create a mask on the iframe
               2. when `pointermove` is not listened, set `pointer-events: none` which makes sure
                  that the iframe can be inspected as expected.
               3. when `pointermove` is listened, set `pointer-events: auto` which make sure that
                  the event is always emitted from current document.
          -->
          <div
            class="preview_component_iframe_mask
            hidden absolute opacity-0 inset-0 mr-4 sm:block pointer-events-none"
          >
          </div>

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

  defp to_srcdoc(assigns) do
    html = ~H"""
    <!doctype html>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link
      phx-track-static
      rel="stylesheet"
      href={Routes.static_path(LabWeb.Endpoint, "/assets/app.css")}
    />
    <body class="antialiased font-sans bg-gray-200 overflow-hidden">
      <div class="bg-gray-100">
        <%= render_slot(@inner_block) %>
      </div>
    </body>
    """

    # from Phoenix.LiveViewTest.rendered_to_string
    # https://github.com/phoenixframework/phoenix_live_view/blob/30ee942b3a18a9e2e1f222a76a707bfba7bd94f7/lib/phoenix_live_view/test/live_view_test.ex#L518
    html
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.safe_to_string()
  end
end
