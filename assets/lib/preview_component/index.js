function is_handler(target) {
  return target.matches('.preview_component .preview_component_handler')
}

function clamp(num, min, max) {
  return Math.min(Math.max(num, min), max)
}

function createOnResizeListener(container, resizeStartX, resizeStartWidth) {
  return (e) => {
    const dx = e.pageX - resizeStartX
    const width = Math.round(resizeStartWidth + dx)
    const minWidth = 375
    const maxWidth = container.parentElement.clientWidth
    container.style.width = `${clamp(width, minWidth, maxWidth)}px`
  }
}

document.addEventListener(
  'pointerdown',
  (e) => {
    if (is_handler(e.target)) {
      const container = e.target.parentElement

      const resizeStartX = e.pageX
      const resizeStartWidth = container.clientWidth

      const onResize = createOnResizeListener(
        container,
        resizeStartX,
        resizeStartWidth
      )

      const onResizeEnd = (_e) => {
        document.removeEventListener('pointermove', onResize, false)
        document.removeEventListener('pointerup', onResizeEnd, false)
        if (container.clientWidth === container.parentElement.clientWidth) {
          container.style.width = '100%'
        }
      }

      document.addEventListener('pointermove', onResize, false)
      document.addEventListener('pointerup', onResizeEnd, false)
    }
  },
  false
)
