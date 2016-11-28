$(function () {
  var rules = {
    'service_type[name]': {
        required: true,
        minlength: 3,
        maxlength: 32
    }
  }
  do_validate('#se1rvice_type_form', rules);
});