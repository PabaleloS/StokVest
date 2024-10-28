import consumer from "./consumer"

consumer.subscriptions.create({ channel: "StokvelChannel", stokvel_id: stokvel_id }, {
  received(data) {
    // Append the new message to the messages container
    const messagesContainer = document.querySelector('.mesaages-container');
    messagesContainer.insertAdjacentHTML('beforeend', data.message);
  }
});
