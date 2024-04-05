import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flashes"
export default class extends Controller {
  static targets = ["flash"]

  connect() {
    // console.log(this.element.firstElementChild)
    // error in console when using this.flashTarget if flash isn't present
    if (this.element.firstElementChild !== null && this.flashTarget.role === 'notice') {
      // div fades
      setTimeout(() => {
        this.flashTarget.classList.add('animate-flashdisappear')
      }, 3000);
      // div is suppressed 50ms after end of animate-flashdisappear
      setTimeout(() => {
        this.flashTarget.style.display = "none"
      }, 3550);
    }
  }
  close() {
    this.flashTarget.style.display = "none"
  }
}
