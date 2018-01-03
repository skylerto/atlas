// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-select
//= require_tree .

$(document).on('ready turbolinks:load', function() {
  // If turbolinks is actin up, fix here.
  $('*:not(.bootstrap-select) > .selectpicker').selectpicker('refresh');

  // $('.job_selection').change(function(val) {
  //   if (val && val.target && val.target.value) {
  //     var val = val.target.value;
  //     console.log(val);
  //     $.ajax({
  //       url: '/' + ,
  //       success: function(result){
  //         $("#div1").html(result);
  //       }
  //     });
  //   }
  // });
});
