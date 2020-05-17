//= require snackbar

function showSnackbarSuccess(text) {
  Snackbar.show({
    pos: "top-center",
    text,
    backgroundColor: "#ebf6e0",
    textColor: "#5f9025",
  });
}

function showSnackbarError(text) {
  Snackbar.show({
    pos: "top-center",
    text,
    backgroundColor: "#ffe9e9",
    textColor: "#de5959",
  });
}
