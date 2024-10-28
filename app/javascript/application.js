// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import "@hotwired/stimulus"
// import "./controllers"
// import "bootstrap";
// import "@popperjs/core"
// import "@rails/actioncable"


import { Application } from "@hotwired/stimulus"
import "./controllers"; // Ensure this line is present


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application };
