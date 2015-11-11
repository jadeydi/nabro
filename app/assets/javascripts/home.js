// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  var date = moment().utc().startOf('day') / 1000,
  lastClickedAt = $('.js-state-btn').data('last-clicked-at');
  $(".js-state-btn").on("click", function(event) {
    if ($(this).data("last-clicked-at") == "") {
      event.preventDefault();
      event.stopPropagation();

      $('.js-need-sign-in').show();
    } else if (date <= lastClickedAt) {
      event.preventDefault();
      event.stopPropagation();

      $('.js-already-clicked').show();
    }
  });
});
