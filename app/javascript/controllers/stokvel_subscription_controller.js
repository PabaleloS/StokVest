import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="stokvel-subscription"
export default class extends Controller {
  static values = { stokvelId: Number, currentUserId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "StokvelChannel", id: this.stokvelIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    console.log(`Subscribed to the Stokvel with the id ${this.stokvelIdValue}.`)
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        <div class="${this.#userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)

  }


  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from this Stokvel")
    this.channel.unsubscribe()
  }
}
