import { Controller } from "@hotwired/stimulus"
import ahoy from "ahoy.js"

// Connects to data-controller="business"
export default class extends Controller {
  connect() {
  }

  trackClick(event){
    ahoy.track("business site visited", {name: event.target.dataset.businessName})
  }
}
