//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(function(){
	$('a.media').media({
		controlbar: 'bottom', 
		width: 300,
		height: 24 
	});
	
	//Refresh list of tasks every 10 secs
	if ($("#js_tasks").length > 0) {
		setTimeout(refreshTaskList, 10000);
	}
});

function refreshTaskList() {
	var article_id = $("#article").attr("data-id");
	if ($(".task").length > 0) {
		var after = $(".task:last-child").attr("data-time");
	} else {
		var after = "0";
	}
	$.getScript("/comments.js?article_id=" + article_id + "&after=" + after)
	setTimeout(refreshTaskList, 10000);
}