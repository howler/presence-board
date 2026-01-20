import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["statusSelect", "noteInput", "submitButton"]

  updateStatus(event) {
    event.preventDefault()
    const form = this.element
    const formData = new FormData(form)
    
    fetch(form.action, {
      method: "PATCH",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        // Show success message
        this.showMessage("Status updated successfully!", "success")
        // The real-time update will be handled by the PresenceChannel
      } else {
        this.showMessage("Failed to update status", "error")
      }
    })
    .catch(error => {
      console.error("Update error:", error)
      this.showMessage("An error occurred", "error")
    })
  }

  showMessage(message, type) {
    // Simple message display - can be enhanced with a toast library
    const messageDiv = document.createElement("div")
    messageDiv.className = `callout ${type === "success" ? "success" : "alert"}`
    messageDiv.textContent = message
    messageDiv.style.cssText = "position: fixed; top: 20px; right: 20px; z-index: 1000;"
    document.body.appendChild(messageDiv)
    
    setTimeout(() => {
      messageDiv.remove()
    }, 3000)
  }
}
