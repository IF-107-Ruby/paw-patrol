import axios from "axios";

const client = axios.create();

client.interceptors.request.use((config) => {
  config.params = config.params || {};
  config.headers = config.headers || {};

  config.params["format"] = "json";
  const csrfTokenEl = document.querySelector("[name=csrf-token]");
  if (csrfTokenEl) {
    config.headers["X-CSRF-TOKEN"] = csrfTokenEl.content;
  }
  return config;
});

export default client;
