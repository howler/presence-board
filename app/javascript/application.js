// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "@hotwired/stimulus-loading"
import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// Import and register all controllers
import PresenceController from "controllers/presence_controller"
import SearchController from "controllers/search_controller"
import StatusUpdateController from "controllers/status_update_controller"
import FlashController from "controllers/flash_controller"
import KioskController from "controllers/kiosk_controller"

application.register("presence", PresenceController)
application.register("search", SearchController)
application.register("status-update", StatusUpdateController)
application.register("flash", FlashController)
application.register("kiosk", KioskController)
