import { Controller } from "stimulus"
// import Rails from 'rails-ujs'

export default class extends Controller {
  static targets = [ 'counter' ];

  connect() {
    console.log('connecting with stimulus controller')
  }

  upvote() {
    const cocktailId = this.data.get('cocktailid')
    console.log('upvoting cocktail number: ' + cocktailId)

    fetch(
      `/cocktails/${cocktailId}/upvote`, 
      { 
        method: 'POST',
        credentials: 'same-origin',
        headers: { 
          accept: "application/json",
          'X-CSRF_Token': require("@rails/ujs").csrfToken()
        } 
      }
    )
    .then(response => response.json())
    .then((data) => {
      this.counterTarget.innerText = data.cocktail.votes
    });

     // id = <cocktailId> ==> POST /cocktails/<cocktailId>/upvote/
    // console.log(this.counterTarget)
  }

  downvote() {
    console.log('downvoting this cocktail')
  }
}