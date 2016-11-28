$(function () {
  $('.datetimepicker').bootstrapMaterialDatePicker({
      format: 'dddd DD MMMM YYYY - HH:mm',
      clearButton: true,
      weekStart: 1,
      setMinDate: moment()
  }).on('change', function(e, date) {
    $('#task_when').val(date.format('YYYY-MM-DD HH:mm'));
  });

  $('.datepicker').bootstrapMaterialDatePicker({
        format: 'MM/DD/YYYY',
        clearButton: true,
        weekStart: 1,
        time: false,
        setMinDate: moment()
    }).on('change', function(e, date) {
      $('#end_on').val(date.format('YYYY-MM-DD 23:59:59'));
    });;

  $('.colorpicker').colorpicker();

  $(".single_service input").click(function() {
    if ($(this).val() == 1) {
      $('#repeat_form').slideUp();
    } else {
      $('#repeat_form').slideDown();
    }
  });

  $("#repeat").change(function () {
    if ($(this).val() == 'm') {
      $('.repeat_on').hide();
      $('.repeat_by').show();
      $('.repeat_period').text('Month(s)')
    } else if ($(this).val() == 'w') {
      $('.repeat_by').hide();
      $('.repeat_on').show();
      $('.repeat_period').text('Week(s)')
    }
  });

    var rules = {
    'task[activity]': {
        required: true,
        minlength: 3,
        maxlength: 32
    },
    'task[when]': {
        required: true,
        email: true
    },
    'task[color]': {
      required: true,
      regex: "/^#[0-9A-F]{6}$/i"
    }
  }
  do_validate('#task_form', rules);
});
