// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.outputTarget.textContent = 'Hello, Stimulus!'
  }
  calculateSnowball(event) {
    event.preventDefault()
    console.log(event)
    const {valueAsNumber:amount} = event.target.previousSibling.previousSibling
    fetch(`/snowball/${amount}`)
      .then(response => response.json())
      
      .then(function(data) {
        console.log(data)
      })
      .catch(error => console.log(error))

    const account_1 = document.querySelector(`#account1`)
    account_1.innerText = '5000'
  }
}
