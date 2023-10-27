import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="books--card"
export default class extends Controller {
  
  showModal(){
    console.log("showModal fired")
    const bookId = this.data.get("id");
    console.log("bookId:" + bookId)
    const modalElement = document.querySelector(`[data-books--quick-view-id="${bookId}"]`);
    console.log(modalElement)

    if (modalElement) {
      modalElement.classList.add('is-active');
    }
  }
}
