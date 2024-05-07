import { Controller } from "@hotwired/stimulus"
import Choices from "choices.js"
import 'choices.js/public/assets/styles/choices.min.css';

// Connects to data-controller="choices"
export default class extends Controller {
  connect() {
    const select = this.element.querySelector("select")
    this.choices = new Choices(select, {
    });
  }

  disconnect() {
    this.choices.destroy();
  }
}
