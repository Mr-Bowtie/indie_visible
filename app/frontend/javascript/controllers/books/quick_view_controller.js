import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="books--quick-view"
export default class extends Controller {
  static targets = ["modal"]

  close(){
    this.modalTarget.classList.remove('is-active')
  }
}