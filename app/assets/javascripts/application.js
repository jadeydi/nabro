// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery_ujs
//= require tether
//= require bootstrap
//= require turbolinks
//= require jquery.interactive_bg
//= require jquery.timeago

jQuery.timeago.settings.strings = {
  prefixAgo: null,
  prefixFromNow: "从现在开始",
  suffixAgo: "之前",
  suffixFromNow: null,
  seconds: "不到1分钟",
  minute: "大约1分钟",
  minutes: "%d分钟",
  hour: "大约1小时",
  hours: "大约%d小时",
  day: "1天",
  days: "%d天",
  month: "大约1个月",
  months: "%d月",
  year: "大约1年",
  years: "%d年",
  numbers: [],
  wordSeparator: ""
};

$(document).on('ready page:load', function() {
  $("time.timeago").timeago();

  $("#bg-overlay").interactive_bg({
    strength: 15,
    scale: 1.02,
    animationSpeed: "200ms",
    contain: true,
    wrapContent: false
  });
});

$(window).resize(function() {
  $("#bg-overlay > .ibg-bg").css({
    width: $(window).outerWidth(),
    height: $(window).outerHeight()
  });
});
