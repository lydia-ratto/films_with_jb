import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-film"
export default class extends Controller {

  select(e) {
    const selectedFilm = e.target.closest(".found_film")
    const imdbID = selectedFilm.dataset.id;
    const foundFilms = document.querySelectorAll(".found_film");
    const idField = document.querySelector("#film_imdb_id");

    foundFilms.forEach((film) => {
      film.classList.toggle("selected")
      film.classList.toggle("hidden")
    });
    selectedFilm.classList.remove("hidden");

    idField.value = imdbID; 
  }
}
