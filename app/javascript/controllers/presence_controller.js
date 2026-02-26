import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { channel: String }

  connect() {
    this.boundHandleUpdate = (event) => this.handleUpdate(event.detail)
    document.addEventListener("presence:update", this.boundHandleUpdate)

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
    document.removeEventListener("presence:update", this.boundHandleUpdate)
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
        // Update the status display (Foundation uses .label; kiosk uses .status-badge)
        const statusIndicator = userCard.querySelector(".label, .status-badge")
        if (statusIndicator) {
          statusIndicator.style.backgroundColor = data.user.status.color_code
          statusIndicator.innerHTML = `
            ${data.user.status.icon ? `<span>${data.user.status.icon}</span> ` : ""}
            ${data.user.status.label}
          `
        }

        // Update note within this card only
        const noteElement = userCard.querySelector(".user-note, p.small[style*='font-style: italic']")
        if (data.user.note) {
          if (noteElement) {
            noteElement.textContent = data.user.note
          } else {
            const newNote = document.createElement("p")
            newNote.className = "small user-note"
            newNote.style.cssText = "margin-top: 5px; font-style: italic; color: #666;"
            newNote.textContent = data.user.note
            const lastUpdatedEl = userCard.querySelector(".last-updated")
            const parent = statusIndicator ? statusIndicator.parentElement : userCard.querySelector(".card-section")
            if (parent) {
              if (lastUpdatedEl) {
                parent.insertBefore(newNote, lastUpdatedEl)
              } else {
                parent.appendChild(newNote)
              }
            }
          }
        } else if (noteElement) {
          noteElement.remove()
        }

        // Update last updated time within this card only
        const lastUpdateEl = userCard.querySelector(".last-updated, [data-presence-target='lastUpdate']")
        if (lastUpdateEl) {
          lastUpdateEl.textContent = "Last updated: just now"
        } else {
          const parent = userCard.querySelector(".card-section .cell.small-9, .card-section")
          if (parent) {
            const p = document.createElement("p")
            p.className = "small last-updated"
            p.style.cssText = "margin-top: 5px; color: #999;"
            p.textContent = "Last updated: just now"
            parent.appendChild(p)
          }
        }
      }
    }
  }
}
