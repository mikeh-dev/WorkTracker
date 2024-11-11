import { Controller } from "@hotwired/stimulus"
import { useTransition, useClickOutside } from "stimulus-use"

export default class extends Controller {
  static targets = ["container", "content"]

  connect() {
    useTransition(this, {
      element: this.contentTarget,
    })
    useClickOutside(this, {
      element: this.contentTarget,
    })
  }

  open(event) {
    console.log("Click event:", event)
    console.log("Target element:", event.target)
    console.log("Dataset:", event.target.dataset)
    console.log("Full size URL:", event.target.dataset.fullSizeUrl)
    
    event.preventDefault()
    const fullSizeUrl = event.target.dataset.fullSizeUrl
    if (!fullSizeUrl) {
      console.error("No full size URL found!")
      return
    }

    const modalImage = this.contentTarget.querySelector('#modal-image')
    if (!modalImage) {
      console.error("Modal image element not found!")
      return
    }

    modalImage.src = fullSizeUrl
    this.enableAppearance()
    this.toggleTransition()
  }

  close(event) {
    event.preventDefault()
    this.leave()
    this.disableAppearance()
  }

  clickOutside(event) {
    const action = event.target.dataset.action
    if (
      action == "click->modal#open" ||
      action == "click->modal#open:prevent"
    ) {
      return
    }
    this.close(event)
  }

  closeWithEsc(event) {
    if (
      event.keyCode === 27 &&
      !this.containerTarget.classList.contains("hidden")
    ) {
      this.close(event)
    }
  }

  enableAppearance() {
    this.containerTarget.classList.remove("hidden")
    this.containerTarget.classList.add(
      "bg-black/80",
      "z-50",
      "transition-opacity",
      "duration-300",
      "ease-out",
      "opacity-100"
    )
  }

  disableAppearance() {
    this.containerTarget.classList.remove(
      "bg-black/80",
      "z-50",
      "opacity-100"
    )
    this.containerTarget.classList.add(
      "opacity-0"
    )
    
    setTimeout(() => {
      this.containerTarget.classList.add("hidden")
    }, 300)
  }

  disconnect() {
    this.toggleTransition()
  }
}
