//Sign Up
$(function () {
  var sign_up_rules = {
    'user[full_name]': {
      required: true,
      minlength: 3,
      maxlength: 32
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
  do_validate('#sign_up', sign_up_rules);
});

//Edit Profile
$(function () {
  var edit_profile_rules = {
    'user[full_name]': {
      required: true,
      minlength: 3,
      maxlength: 32
    }
  }
  do_validate('#edit_profile', edit_profile_rules);
});