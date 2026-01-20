import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { channel: String }

  connect() {
    this.consumer = createConsumer()
    this.subscription = this.consumer.subscriptions.create(
      { channel: "PresenceChannel" },
      {
        received: (data) => {
          this.handleUpdate(data)
        }
      }
    )
  }

  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
    if (this.consumer) {
      this.consumer.disconnect()
    }
  }

  handleUpdate(data) {
    if (data.type === "status_update") {
      const userCard = this.element.querySelector(`[data-user-id="${data.user.id}"]`)
      if (userCard) {
        // Update the status display
        const statusIndicator = userCard.querySelector(".status-indicator, .status-badge")
        if (statusIndicator) {
          statusIndicator.style.backgroundColor = data.user.status.color_code
          statusIndicator.innerHTML = `
            ${data.user.status.icon ? `<span>${data.user.status.icon}</span> ` : ""}
            ${data.user.status.label}
          `
        }

        // Update note if present
        const noteElement = userCard.querySelector("p[style*='font-style: italic']")
        if (data.user.note) {
          if (noteElement) {
            noteElement.textContent = data.user.note
          } else {
            const newNote = document.createElement("p")
            newNote.className = "small"
            newNote.style.cssText = "margin-top: 5px; font-style: italic;"
            newNote.textContent = data.user.note
            statusIndicator.parentElement.appendChild(newNote)
          }
        } else if (noteElement) {
          noteElement.remove()
        }

        // Update last updated time
        const lastUpdate = this.element.querySelector("[data-presence-target='lastUpdate']")
        if (lastUpdate) {
          const now = new Date()
          lastUpdate.textContent = now.toLocaleTimeString()
        }
      }
    }
  }
}
