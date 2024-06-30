import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validate-question"
export default class extends Controller {
  static targets = ["input", "btn", "answerdiv", "goodanswer", "explanation" ]

  connect() {
      //console.log(this.element)
      //console.log(this.inputTargets)
      this.pagination = document.querySelector('.apple_pagination')
      this.questionId = document.querySelector('form').dataset.questionId
      this.token = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
      //console.log(this.pagination)
      //console.log(this.questionId)
      //console.log(this.token)
  }
  showAnswer(event){
      event.preventDefault()
      const inputs = this.inputTargets
      const btn = this.btnTarget
      const checkedInput = inputs.filter(input => input.checked)[0]
      const answerDiv = this.answerdivTarget
      const goodAnswer = this.goodanswerTarget
      const expl = this.explanationTarget
      // si aucne case n'a été cochée et qu'on clic sur le btn valider
      // message d'alerte
      if (checkedInput === undefined){
          alert('Vous devez choisir une réponse avant de valider !');
      // si l'input coché est la bonne réponse, on ajoute un p en vert
      // avec un texte "bonne reponse" et on montre l'explication
      // on scroll au niveau de la pagination
      // si une paire [user_id, question_id] existe dans la table de jointure missed_questions,
      }else if(checkedInput.dataset.value === expl.dataset.value){
          let p = document.createElement('p');
          p.style.fontSize = '1.1rem'
          p.style.color = 'green'
          p.textContent = 'Bonne réponse !'
          answerDiv.prepend(p)
          answerDiv.classList.toggle('hidden')
          btn.classList.toggle('hidden')
          if (this.pagination !== null) {
              this.pagination.scrollIntoView()
          }
          // on supprime de la table de jointure la paire [user_id, question_id]
          if (this.questionId !== undefined) {
              this.destroyFailedQuestion();
          }
      // si l'input coché est la mauvaise réponse, on ajoute un p en rouge
      // avec un texte "mauvaise reponse", on affiche un texte indiquant
      // la bonne reponse on montre l'explication, on scroll au niveau de la pagination
      }else{
          let p = document.createElement('p');
          p.style.fontSize = '1.1rem'
          p.style.color = 'red'
          p.textContent = 'Mauvaise réponse...'
          answerDiv.prepend(p)
          answerDiv.classList.toggle('hidden')
          goodAnswer.classList.toggle('hidden')
          btn.classList.toggle('hidden')
          if (this.pagination !== null){
              this.pagination.scrollIntoView()
          }
          // on crée/stocke dans la table de jointure missed_questions un nouveau record [user_id, question_id]
          if (this.questionId !== undefined){
              this.addFailedQuestion();
          }
      }
  }
  addFailedQuestion(){
      const url = `questions/${this.questionId}/add_failed_question`
      const options = {
          method: "POST",
          headers: { "Accept": "application/json", "X-CSRF-Token": this.token },
          contentType: "application/json",
          body: new FormData() // on crée un FormObject
      }
      fetch(url, options)
          .then(response => response.json())
          .then((data) => {
            console.log(data)
          })
  }
  destroyFailedQuestion(){
    const url = `questions/${this.questionId}/destroy_failed_question`
    const options = {
        method: "POST",
        headers: { "Accept": "application/json", "X-CSRF-Token": this.token },
        contentType: "application/json",
        body: new FormData()
    }
    fetch(url, options)
        .then(response => response.json())
        .then((data) => {
          console.log(data)
        })
  }
}
