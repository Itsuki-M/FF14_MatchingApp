// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
//= require bootstrap-sprockets
import "@hotwired/turbo-rails"
import "controllers"
import "@fortawesome/fontawesome-free"

document.querySelector("#send-message").addEventListener("submit", function(e) {
  e.preventDefault();
  const message = this.querySelector("#message").value;
  this.perform("speak", { message: message });
});
