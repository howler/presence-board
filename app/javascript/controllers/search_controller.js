import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  perform() {
    // Debounce the search
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const form = this.element
      const formData = new FormData(form)
      const params = new URLSearchParams(formData)
      window.location.href = `${window.location.pathname}?${params.toString()}`
    }, 300)
  }
}
