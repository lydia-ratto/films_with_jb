import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "input", "list", "josh_score", "release_year", "genre"]

  update() {
    const joshScoreName = document.querySelectorAll("select")[0]["name"];
    const releaseYearName = document.querySelectorAll("select")[1]["name"];
    const genreName = document.querySelectorAll("select")[2]["name"];
    const joshScoreValue = document.querySelectorAll("select")[0]["value"];
    const releaseYearValue = document.querySelectorAll("select")[1]["value"];
    const genreValue = document.querySelectorAll("select")[2]["value"];
    console.log(this.formTarget.action)
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}&${joshScoreName}=${joshScoreValue}&${releaseYearName}=${releaseYearValue}&${genreName}=${genreValue}`
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
  }

  filter(e) {
    const joshScoreName = document.querySelectorAll("select")[0]["name"];
    const releaseYearName = document.querySelectorAll("select")[1]["name"];
    const genreName = document.querySelectorAll("select")[2]["name"];
    const joshScoreValue = document.querySelectorAll("select")[0]["value"];
    const releaseYearValue = document.querySelectorAll("select")[1]["value"];
    const genreValue = document.querySelectorAll("select")[2]["value"];
    const searchIn = document.querySelector("input")["value"];
    console.log(searchIn);
    const url = `${this.formTarget.action}?${joshScoreName}=${joshScoreValue}&${releaseYearName}=${releaseYearValue}&${genreName}=${genreValue}&query=${searchIn}`
    fetch(url, { headers: { "Accept": "text/plain" } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
      });

  }
}
