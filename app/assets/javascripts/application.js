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
//= require_tree .

$(document).ready(function() {
  if ($('.environment_services')) {
    load_services();
  }
});

function load_services() {
  var services = $('.environment_services').data('services');
  var data = `<div class="environment_services">
    <div class="form-group">
      <label class="col-sm-2 control-label" for="environment_name">Name</label>
      <div class="col-sm-10">
        ${option_select(services)}
      </div>
    </div>
  </div>`;
  console.log(services);
  $('.environment_services').append(data);
}


function option_select(services) {
  var select = `<select name="environment[name]" id="environment_name">`;
  for (var service of services) {
    select = `${select}<option value="${service.id}">${service.name}</option>`
  }
  select = `${select}</select>`;
  return select;
}
