import { Controller } from "@hotwired/stimulus"
import ahoy from "ahoy.js"

// Connects to data-controller="books--card"
export default class extends Controller {

  showModal(){
    ahoy.track("track book click", {title: this.data.scope.element.dataset.bookTitle})
    const bookId = this.data.get("id");
    const modalElement = document.querySelector(`[data-books--quick-view-id="${bookId}"]`);
    const htmlElement = document.querySelector('html')

    if (modalElement) {
      modalElement.classList.add('is-active');
      htmlElement.classList.add('is-clipped');
    }
  }
}
