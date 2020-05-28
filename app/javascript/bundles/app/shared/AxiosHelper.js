import axios from "axios";

const csrfToken = document.querySelector("[name=csrf-token]");
if (csrfToken) {
  axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken.content;
}

export default axios;