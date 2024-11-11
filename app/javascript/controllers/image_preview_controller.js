import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "previewContainer"];

  preview() {
    const files = this.inputTarget.files;
    const previewContainer = this.previewContainerTarget;

    Array.from(files).forEach(file => {
      const reader = new FileReader();

      reader.onloadend = () => {
        console.log("File:", file.name);
        const previewWrapper = document.createElement('div');
        previewWrapper.className = 'relative group';

        const img = document.createElement('img');
        img.className = 'w-24 h-24 rounded-lg object-cover border-2 border-white shadow-sm dark:border-zinc-700 cursor-pointer';
        img.dataset.imagePreviewTarget = 'preview';
        img.dataset.action = 'click->modal#open';
        img.dataset.fullSizeUrl = reader.result;
        img.src = reader.result;

        previewWrapper.appendChild(img);
        previewContainer.appendChild(previewWrapper);
      };

      reader.readAsDataURL(file);
    });
  }
}