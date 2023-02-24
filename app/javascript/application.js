// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

const DARK_MODE = "(prefers-color-scheme: dark)"

function updateTheme() {
  const colorMode = window.matchMedia(DARK_MODE).matches ? "dark" : "light";
  document.querySelector("html").setAttribute("data-bs-theme", colorMode);
}

updateTheme();
window.matchMedia(DARK_MODE).addEventListener("change", updateTheme);
