import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="books--card"
export default class extends Controller {
  
  showModal(){
    const bookId = this.data.get("id");
    const modalElement = document.querySelector(`[data-books--quick-view-id="${bookId}"]`);
    const htmlElement = document.querySelector('html')

    if (modalElement) {
      modalElement.classList.add('is-active');
      htmlElement.classList.add('is-clipped');
    }
  }
}
