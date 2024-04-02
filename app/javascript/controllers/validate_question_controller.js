import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validate-question"
export default class extends Controller {
  static targets = ["input", "btn", "answerdiv", "goodanswer", "explanation" ]
  connect() {
      //console.log(this.element)
      //console.log(this.inputTargets)
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
      }else if(checkedInput.dataset.value === expl.dataset.value){
          let p = document.createElement('p');
          p.style.fontSize = '1.1rem'
          p.style.color = 'green'
          p.textContent = 'Bonne réponse !'
          answerDiv.prepend(p)
          answerDiv.classList.toggle('hidden')
          btn.classList.toggle('hidden')
          document.querySelector('.apple_pagination').scrollIntoView()
      // si l'input coché est la mauvaise réponse, on ajoute un p en rouge
      // avec un texte "mauvaise reponse", on affiche un texte indiquant
      // la bonne reponse on montre l'explication, on scroll au niveau de la pagination
      }else{
          let p = document.createElement('p');
          p.style.fontSize = '1.1rem';
          p.style.color = 'red';
          p.textContent = 'Mauvaise réponse...'
          answerDiv.prepend(p);
          answerDiv.classList.toggle('hidden');
          goodAnswer.classList.toggle('hidden');
          btn.classList.toggle('hidden');
          document.querySelector('.apple_pagination').scrollIntoView();
      }
  }
}
