import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["creditCard"]

  switch(event) {
    event.preventDefault()
    if (this.creditCardTarget.classList.length >= 1) {
      this.creditCardTarget.classList.remove('hidden');
    } else {
      this.creditCardTarget.classList.add('hidden');
    };
  }
}
