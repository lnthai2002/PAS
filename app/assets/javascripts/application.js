// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
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
