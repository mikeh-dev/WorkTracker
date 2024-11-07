import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

const currentDate = new Date()
const oneWeekLater = new Date(currentDate.getTime() + 7 * 24 * 60 * 60 * 1000)

export default class extends Controller {
  static targets = ["label", "startDate", "endDate", "wrapper"]
  static values = {
    mode: String || "",
    minDate: String || "today",
    dateFormat: String || "Y-m-d",
    range: {
      type: Array,
      default: [currentDate, oneWeekLater],
    },
  }

  connect() {
    // Get existing dates from hidden fields if they exist
    const startDate = this.startDateTarget.value
    const endDate = this.endDateTarget.value
    
    // Use existing dates if present, otherwise use default range
    const defaultDates = (startDate && endDate) 
      ? [new Date(startDate), new Date(endDate)]
      : this.rangeValue.map((dateString) => new Date(dateString))

    let self = this
    const picker = flatpickr(this.wrapperTarget, {
      mode: "range",
      minDate: this.minDateValue,
      dateFormat: this.dateFormatValue,
      defaultDate: defaultDates,
      onChange: function (selectedDates, dateStr, instance) {
        self.setCurrentRange(instance)
      },
    })

    this.setCurrentRange(picker)
  }

  setCurrentRange(picker) {
    const formatDate = (date) => {
      const options = { month: "short", day: "numeric" }
      return date.toLocaleDateString("en-US", options)
    }

    const formatDateForField = (date) => {
      return date.toISOString().split('T')[0] // Returns YYYY-MM-DD
    }

    if (picker.selectedDates.length === 2) {
      // Update the display label
      const range = picker.selectedDates.map(formatDate).join(" - ")
      this.labelTarget.textContent = range

      // Update the hidden form fields
      this.startDateTarget.value = formatDateForField(picker.selectedDates[0])
      this.endDateTarget.value = formatDateForField(picker.selectedDates[1])
    }
  }
}
