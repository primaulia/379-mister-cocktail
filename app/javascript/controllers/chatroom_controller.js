import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ 'messages' ];

  connect() {
    const messagesContainer = this.messagesTarget

    this.subscription = consumer.subscriptions.create({
      channel: "ChatroomChannel",
      id: this.data.get("id")
    }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data)
      }
    });
  }
}