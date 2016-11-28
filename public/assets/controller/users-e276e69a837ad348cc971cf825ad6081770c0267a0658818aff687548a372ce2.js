var rules = {
  'user[full_name]': {
    required: true,
    minlength: 3
  },
  'user[email]': {
    required: true,
    email: true
  },
  'user[password]': {
    required: true,
    minlength: 6
  },
  'user[password_confirmation]': {
    equalTo: '[name="user[password]"]'
  }
}
do_validate('#sign_up', rules);
