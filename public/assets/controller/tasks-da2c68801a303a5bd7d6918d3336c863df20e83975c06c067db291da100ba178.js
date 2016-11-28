$(function () {
  //Datetimepicker plugin
  $('.datetimepicker').bootstrapMaterialDatePicker({
      format: 'dddd DD MMMM YYYY - HH:mm',
      clearButton: true,
      weekStart: 1,
      setMinDate: moment()
  }).on('change', function(e, date) {
    $('#task_when').val(date.format('YYYY-MM-DD HH:mm'));
  });
});
