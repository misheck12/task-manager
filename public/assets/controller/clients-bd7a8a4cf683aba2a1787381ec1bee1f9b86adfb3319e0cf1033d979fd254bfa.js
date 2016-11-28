$(function () {
  var rules = {
    'client[name]': {
        required: true,
        minlength: 3,
        maxlength: 32
    },
    'client[email]': {
        required: true,
        email: true
    },
    'client[site]': {
      required: true,
      url: true
    }
  }
  do_validate('#client_form', rules);
});
