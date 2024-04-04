import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="qcm-results"
export default class extends Controller {
  static targets = ["submitbtn", "correctionbtn", "qcmTitle", "formGeneral", "formSpecific", "modalDiv", "modalBody",
                    "answer", "homeLink", "timerDiv", "min", "sec"]

  connect() {
    //console.log(this.element)
    //console.log(this.submitbtnTarget)
    //console.log(this.correctionbtnTarget)
    //console.log(this.qcmTitleTarget.dataset.level)
    this.launchTimer()
  }
  handleSubmit(event){
      event.preventDefault
      const arrayGeneral = []
      const arraySpecific = []
      const level = this.qcmTitleTarget.dataset.level
      let resultGe;
      let resultSpe;
      let total;
      // on ajoute 1 ds arrayGeneral à chq bonne reponse pr la partie generale et
      // on attribue une class couleur en fonction de bonne ou mauvaise reponse ou
      // pas de réponse
      const formsGe = this.formGeneralTargets
      formsGe.forEach(function (form) {
          let indexForm = form.dataset.index
          let goodAnswer = form.dataset.goodAnswer
          const inputs = document.querySelectorAll(`input[name=question-general-${indexForm}]`)
          inputs.forEach(function (input) {
              if (input.checked && goodAnswer === input.value){
                  arrayGeneral.push(1)
                  input.classList.add('green')
              }
              else if (input.checked && goodAnswer !== input.value){
                  input.classList.add('red')
              }
              else if (input.checked === false){
                  input.classList.add('blue')
              }
          })
      })
      // on ajoute 1 ds arraySpecific à chq bonne reponse pr la partie specifique et
      // on attribue une class couleur en fonction de bonne ou mauvaise reponse ou
      // pas de reponse
      const formsSpe = this.formSpecificTargets
      formsSpe.forEach(function (form) {
          let indexForm = form.dataset.index
          let goodAnswer = form.dataset.goodAnswer
          const inputs = document.querySelectorAll(`input[name=question-specific-${indexForm}]`)
          inputs.forEach(function (input) {
              if (input.checked && goodAnswer === input.value){
                  arraySpecific.push(1)
                  input.classList.add('green')
              }
              else if (input.checked && goodAnswer !== input.value){
                  input.classList.add('red')
              }
              else if (input.checked === false){
                  input.classList.add('blue')
              }
          })
      })
      // on fait le total des points et on l'affiche dans une modal
      resultGe = arrayGeneral.reduce((acc, currentV) => acc + currentV, 0)
      resultSpe = arraySpecific.reduce((acc, currentV) => acc + currentV, 0)
      total = resultGe + resultSpe
      const content = document.createTextNode(level === 'départemental' ? `Vous avez ${total} bonnes réponses sur 20 questions` : `vous avez ${total} bonnes réponses sur 30 questions`)
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
  handleCorrection(){
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
  launchTimer() {
      //lancer le timer
      const level = this.qcmTitleTarget.dataset.level
      const timerDiv = this.timerDivTarget
      const minSpan = this.minTarget
      const secSpan = this.secTarget
      const submitButton = this.submitbtnTarget
      let time;
      level === 'départemental' ? time = 1200 : time = 1800 // nb de min en secondes
      console.log(time)
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
