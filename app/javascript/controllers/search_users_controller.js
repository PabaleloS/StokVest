// app/javascript/controllers/search_users_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "form", "input", "users_list", "results" ];

  connect() {
    console.log('seach users controller connected')
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`;
    fetch(url,{
      headers: { "Accept": "text/plain" }
    })
      .then(response => response.text())
      .then(data => {
        console.log({data})
        this.users_listTarget.outerHTML = data;
      })
  }
}
