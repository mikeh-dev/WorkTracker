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
    const startDate = this.startDateTarget.value
    const endDate = this.endDateTarget.value
    
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
      return date.toISOString().split('T')[0] 
    }

    if (picker.selectedDates.length === 2) {
      const range = picker.selectedDates.map(formatDate).join(" - ")
      this.labelTarget.textContent = range

      this.startDateTarget.value = formatDateForField(picker.selectedDates[0])
      this.endDateTarget.value = formatDateForField(picker.selectedDates[1])
    }
  }
}
