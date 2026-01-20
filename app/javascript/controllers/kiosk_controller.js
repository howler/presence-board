import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Auto-refresh kiosk mode every 30 seconds as a fallback
    this.refreshInterval = setInterval(() => {
      if (document.visibilityState === "visible") {
        window.location.reload()
      }
    }, 30000)
  }

  disconnect() {
    if (this.refreshInterval) {
      clearInterval(this.refreshInterval)
    }
  }
}
