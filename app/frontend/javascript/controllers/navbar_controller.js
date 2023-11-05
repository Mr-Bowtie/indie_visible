import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  toggleMenu() {
    const target = this.scope.element.dataset.target
    const menu = document.getElementById(target)
    this.scope.element.classList.toggle('is-active')
    menu.classList.toggle('is-active')
  }
}

