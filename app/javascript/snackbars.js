import Snackbar from "node-snackbar";

export function showSnackbarSuccess(text) {
  Snackbar.show({
    pos: "top-center",
    text,
    backgroundColor: "#ebf6e0",
    textColor: "#5f9025",
    showAction: false,
  });
}

export function showSnackbarError(text) {
  Snackbar.show({
    pos: "top-center",
    text,
    backgroundColor: "#ffe9e9",
    textColor: "#de5959",
    showAction: false,
  });
}
