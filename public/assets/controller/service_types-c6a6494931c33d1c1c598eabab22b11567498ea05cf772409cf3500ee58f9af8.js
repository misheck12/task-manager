$(function () {
  var rules = {
    'service_type[name]': {
        required: true,
        minlength: 3,
        maxlength: 32
    }
  }
  do_validate('#service_type_form', rules);
});
