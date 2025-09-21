import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["actionMenu"];

  actions() {
    this.actionMenuTarget.classList.toggle("hidden");
  }

  closeActions() {
    if (this.actionMenuTarget.classList.contains("hidden")) {
      return;
    }

    this.actionMenuTarget.classList.add("hidden");
  }
}
