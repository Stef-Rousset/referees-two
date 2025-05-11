import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="qcm-results"
export default class extends Controller {
  static targets = ["submitbtn", "correctionbtn", "formGeneral", "modalDiv", "modalBody",
                    "homeLink", "timerDiv", "min", "sec"]

  connect() {
    this.launchTimer()
    this.token = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
    // lexiconsIds est un array contenant tous les ids des questions
    this.lexiconsIds = JSON.parse(document.querySelector('.qcm-lexicon').dataset.lexicon)
    window.addEventListener("scroll", this.showBackToTopBtn)
  }
  handleSubmit(event) {
    event.preventDefault
    const result = []
    // on ajoute l'id ds arrayGeneral à chq bonne reponse pr la partie generale et
    // on attribue une class couleur en fonction de bonne ou mauvaise reponse ou
    // pas de réponse
    const formsGe = this.formGeneralTargets
    formsGe.forEach(function (form) {
      let indexForm = form.dataset.index
      let goodAnswer = form.dataset.goodAnswer
      let lexiconId = form.dataset.lexiconId
      const inputs = document.querySelectorAll(`input[name=lexicon-general-${indexForm}]`)
      inputs.forEach(function (input) {
        if (input.checked && goodAnswer === input.value) {
          result.push(lexiconId)
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
    // on ajoute le score dans la table LexiconResult
    this.createLexiconResult(result.length)
    // on affiche le total des points dans une modal
    const content = document.createTextNode(`Vous avez ${result.length} bonne(s) réponse(s) sur 20 questions`)
    this.modalBodyTarget.appendChild(content)
    const modalDiv = this.modalDivTarget
    modalDiv.classList.toggle("hidden")
    //animation de la modal
    modalDiv.classList.add('animate-modal')
    modalDiv.classList.add('lg:animate-modallg')
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
    inputs.forEach(function (input) {
      if (input.classList.contains('red') || input.classList.contains('blue')) {
        // on recup le p qui dit la bonne reponse est
        input.parentElement.parentElement.lastElementChild.classList.toggle('hidden')
      }
    })
    this.modalDivTarget.classList.toggle("hidden")
    this.submitbtnTarget.classList.toggle('hidden')
    this.homeLinkTarget.classList.toggle('hidden')
    document.querySelector('.qcm-lexicon-container').scrollTop = 0

  }
  // ajouter le score à la table LexiconResult via un call ajax
  async createLexiconResult(score){
    const url = `add_lexicon_result`
    const formData = new FormData()
    formData.append("score", `${score}`)
    const options = {
      method: "POST",
      headers: { "X-CSRF-Token": this.token },
      contentType: "application/json", // type of data sent
      body: formData,
    }
    const response = await fetch(url, options)
    if (response.status == 200) {
      console.log("ok")
    }else{
      console.log("something went wrong...")
    }
  }

  launchTimer() {
    //lancer le timer
    const timerDiv = this.timerDivTarget
    const minSpan = this.minTarget
    const secSpan = this.secTarget
    const submitButton = this.submitbtnTarget
    let time = 1200 // nb de min en secondes

    const interval = setInterval(handleTimer, 1000); // intervalle d'1 sec en milliseconds
    function handleTimer() {
      let minutes = parseInt(time / 60, 10);
      let seconds = parseInt(time % 60, 10);

      minutes = minutes < 10 ? "0" + minutes : minutes; // on affiche 09 min et pas 9 min
      seconds = seconds < 10 ? "0" + seconds : seconds; // on affiche 07 sec et pas 7 sec
      secSpan.innerHTML = seconds
      minSpan.innerHTML = minutes

      // on décrémente time de 1 et quand on arrive sous 60 sec, la div devient rouge
      // quand on arrive à zero, on arrête l'intervalle et on soumet le formulaire
      if (time == 0) {
        clearInterval(interval)
        submitButton.click()  //submit le form
      } else if (time-- < 60) {
        timerDiv.style.backgroundColor = "red";
      }
      // au clic sur le btn valider, on stoppe le timer et on remet la div du
      // timer dans sa couleur d'origine
      submitButton.addEventListener('click', function () {
        clearInterval(interval);
        if (timerDiv.style.backgroundColor === "red") {
          timerDiv.style.backgroundColor = "bg-gray-500";
        }
      })
    }
  }
}
