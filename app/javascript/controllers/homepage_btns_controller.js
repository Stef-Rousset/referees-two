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
}
