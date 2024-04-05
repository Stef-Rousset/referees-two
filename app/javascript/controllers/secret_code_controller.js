import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="secret-code"
export default class extends Controller {
  static targets = ["signin"]

  connect() {
    //console.log(this.element)
    //console.log(this.signinTarget)
    this.array = []
    document.addEventListener('keyup', (event) => this.handleSecretCode(event, this.array))
  }

  handleSecretCode(event, array) {
    //console.log(event.key)
    //console.log(array)
    const secretCode = document.querySelector('meta[name=env]').content
    const signin = this.signinTarget
    this.array.push(event.key)
    console.log(this.array)
    this.array.splice(-secretCode.length - 1, this.array.length - secretCode.length)
    if (this.array.join('').includes(secretCode)) {
      signin.classList.remove('hidden')
    }
  }
}
