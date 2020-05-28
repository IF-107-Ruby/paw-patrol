import axios from "axios";

const csrfTokenEl = document.querySelector("[name=csrf-token]");
if (csrfTokenEl) {
  axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfTokenEl.content;
}

export default axios;