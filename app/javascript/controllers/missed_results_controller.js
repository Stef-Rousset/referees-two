import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="qcm-results"
export default class extends Controller {
  static targets = ["submitbtn", "correctionbtn", "countGeneral", "formGeneral", "modalDiv", "modalBody",
    "answer", "homeLink"]

  connect() {
    this.token = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
    this.count = this.countGeneralTarget.dataset.count
    console.log(this.count)
    // questionsQcm est un array contenant tous les ids des questions
    this.questionsQcm = JSON.parse(document.querySelector('.qcm-general-questions').dataset.missedQuestions)
    window.addEventListener("scroll", this.showBackToTopBtn)
  }
  handleSubmit(event) {
    event.preventDefault
    const arrayGeneral = []
    let resultGe;
    // à chq bonne reponse, on ajoute l'id ds arrayGeneral et
    // on attribue une class couleur en fonction de bonne ou mauvaise reponse ou
    // pas de réponse
    const formsGe = this.formGeneralTargets
    formsGe.forEach(function (form) {
      let indexForm = form.dataset.index
      let goodAnswer = form.dataset.goodAnswer
      let questionId = form.dataset.questionId
      const inputs = document.querySelectorAll(`input[name=question-general-${indexForm}]`)
      inputs.forEach(function (input) {
        if (input.checked && goodAnswer === input.value) {
          arrayGeneral.push(questionId)
          input.classList.add('green')
        }
        else if (input.checked && goodAnswer !== input.value) {
          input.classList.add('red')
        }
        else if (input.checked === false) {
          input.classList.add('blue')
        }
      })
    })
    // on fait le total des points et on l'affiche dans une modal
    resultGe = arrayGeneral.length
    const content = document.createTextNode(`Vous avez ${resultGe} bonne(s) réponse(s) sur ${this.count} question(s) à revoir`)
    this.modalBodyTarget.appendChild(content)
    const modalDiv = this.modalDivTarget
    modalDiv.classList.toggle("hidden")
    //animation de la modal
    modalDiv.classList.add('animate-modal')
    modalDiv.classList.add('lg:animate-modallg')
    // on met à jour la table de jointure missed_questions
    // en supprimant les bonnes réponses de la table
    this.destroyFailedQuestions(arrayGeneral.toString())
  }
  close() {
    // hide modal
    this.modalDivTarget.classList.toggle("hidden")
  }
  handleCorrection() {
    // au clic sur le btn voir correction, on affiche les div d'explications
    // et on passe les mauvaises réponses en rouge et les bonnes en vert
    // si mauvaise reponse ou pas de reponse, on affiche le p qui indique la bonne reponse
    // on cache le btn valider les reponses et on display le lien retour accueil
    // on scroll au début du qcm
    const inputs = document.querySelectorAll('input')
    document.querySelectorAll('.green').forEach(elem => elem.parentElement.style.color = "green")
    document.querySelectorAll('.red').forEach(elem => elem.parentElement.style.color = "red")
    this.answerTargets.forEach(answer => answer.classList.toggle('hidden'))
    inputs.forEach(function (input) {
      if (input.classList.contains('red') || input.classList.contains('blue')) {
        // on recup le p qui donne la bonne reponse
        input.parentElement.parentElement.lastElementChild.firstElementChild.classList.toggle('hidden')
      }
    })
    this.modalDivTarget.classList.toggle("hidden")
    this.submitbtnTarget.classList.toggle('hidden')
    this.homeLinkTarget.classList.toggle('hidden')
    document.querySelector('.qcm-container').scrollTop = 0

  }
  // enlever de la table de jointure les réponses correctes,
  // via un call ajax
  async destroyFailedQuestions(questionIds) {
    const url = `questions/destroy_failed_questions`
    const formData = new FormData()
    formData.append("ids", `${questionIds}`)
    const options = {
      method: "POST",
      headers: { "X-CSRF-Token": this.token },
      contentType: "application/json", // type of data sent
      body: formData,
    }
    const response = await fetch(url, options)
    if (response.status == 200) {
      console.log("ok")
    }
  }
}
