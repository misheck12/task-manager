(function() {
  var rules = {
    'auth[email]': {
        required: true,
        email: true
    },
    'auth[password]': {
      required: true
    }
  }
  do_validate('#sign_in', rules);
  console.log('OK');
});
