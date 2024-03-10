    import { Controller } from "@hotwired/stimulus"

    // Connects to data-controller="series"
    export default class extends Controller {
        static targets = ["seriesCheckbox", "seriesInputs"]

        connect() {
            this.toggleSeriesInputs();
        }

        toggleSeriesInputs() {
            if (this.seriesCheckboxTarget.checked) {
                this.seriesInputsTarget.classList.remove("is-hidden");
            } else {
                this.seriesInputsTarget.classList.add("is-hidden");
            }
        }

    }
