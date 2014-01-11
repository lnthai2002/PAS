// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
// Note: Foundation 5 won't work with turbolinks
//= require foundation
//= require_tree .

$(document).ready(function(){
	//show and hide right menu----------------------------
	//hide all sub-menu
	$('.navigation fieldset').children('ul').find('ul').hide();
	//show all sub-menu which is current
	var submenus = $('.navigation fieldset').children('ul').find('ul') //find all submenus
	$(submenus).each(function(){
	  var current_submenu = $(this)
	  if (current_submenu.prevAll('li').first().hasClass('current')){
	  	current_submenu.show();
	  }
	})
})


$(function() {
  $(document).foundation();
});
