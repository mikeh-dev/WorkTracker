import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "previewContainer"];

  connect() {
    console.log("ImagePreviewController connected");
  }

  preview() {
    const files = this.inputTarget.files;
    const previewContainer = this.previewContainerTarget;

    console.log("Files:", files);
    console.log("Preview container:", previewContainer);

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
        console.log("Preview appended");
      };

      reader.readAsDataURL(file);
    });
  }
}