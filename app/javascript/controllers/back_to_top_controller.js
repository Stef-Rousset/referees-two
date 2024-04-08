import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="back-to-top"
export default class extends Controller {
  static targets = ["mainDiv", , "backToTopBtn"]
  connect() {
  }
  showBtn() {
      // quand le scroll à l'interieur du container dépasse 600, on affiche le btn
      // de retour rapide en haut de container. Si on rescroll vers le haut, on l'enlève
      const main = this.mainDivTarget
      const scrolledPixs = main.scrollTop //scrollTop returns the nb of px dwhose element is scrolled
    const button = this.backToTopBtnTarget
      if (scrolledPixs >= 100) {
        button.classList.remove('hidden')
      } else if (scrolledPixs <= 100) {
        button.classList.add('hidden')
      }
  }
  upToTop(){
      // go back to top of page
    const main = this.mainDivTarget
      main.scrollTo({
          top: 0,
          behavior: "smooth",
      });
  }
}
