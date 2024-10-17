# Pin npm packages by running ./bin/importmap

# pin "application"
# pin "@hotwired/turbo-rails", to: "turbo.min.js"
# pin "@hotwired/stimulus", to: "stimulus.min.js"
# pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
# pin_all_from "app/javascript/controllers", under: "controllers"

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "https://cdn.skypack.dev/@hotwired/turbo-rails"
pin "@hotwired/stimulus", to: "https://cdn.skypack.dev/@hotwired/stimulus"
pin "@hotwired/stimulus-loading", to: "https://cdn.skypack.dev/@hotwired/stimulus-loading"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js", preload: true
pin "@popperjs/core", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js", preload: true
pin "@rails/actioncable", to: "https://cdn.skypack.dev/@rails/actioncable", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
