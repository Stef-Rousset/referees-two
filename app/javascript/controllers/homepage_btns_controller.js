import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="homepage-btns"
export default class extends Controller {
  static targets = ["paragraph", "questions", "qcm", "questionchoice", "qcmchoice"]

  connect() {
    //console.log(this.element)
    //console.log(this.questionsTarget)
    //console.log(this.qcmTarget)
    //console.log(this.questionchoiceTarget)
    //console.log(this.qcmchoiceTarget)
  }

  showQuestions(){
    const paragraph = this.paragraphTarget
    const questionChoice = this.questionchoiceTarget
    // on click hide paragraph and show div to choose type of questions
    paragraph.classList.add('hidden')
    questionChoice.classList.remove('hidden')
  }
  showQcm(){
    const paragraph = this.paragraphTarget
    const qcmChoice = this.qcmchoiceTarget
    // on click hide paragraph and show div to choose type of qcm
    paragraph.classList.add('hidden')
    qcmChoice.classList.remove('hidden')
  }
  launchTimer() {
    //lancer le timer
    const level = this.qcmTitleTarget.dataset.level
    const timerDiv = this.timerDivTarget
    const minSpan = this.minTarget
    const secSpan = this.secTarget
    const submitButton = this.submitQcmBtnTarget

    if (level) {
      let time;
      level.dataset.level === 'départemental' ? time = 1200 : time = 1800 // nb de min en secondes
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
            timerDiv.style.backgroundColor = "#e6e6e6";
          }
        })
      }
    }
  }
}
