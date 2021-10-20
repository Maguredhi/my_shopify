import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["object"]

  switch(event) {
    event.preventDefault()
    if (this.objectTarget.classList.contains('hidden')) {
      this.objectTarget.classList.remove('hidden');
    } else {
      this.objectTarget.classList.add('hidden');
    };
  }
}
