$(document).ready(function() {
	$('#bubbles')
		.mouseover(function(e) {
			var bubble = $(e.target);
			bubble = bubble.is('.bubble') ? bubble : bubble.parent();
			bubble = bubble.is('.control') ? bubble.parent() : bubble;
			bubble.addClass("bubbled")
			$("#ctrl_" + bubble.attr("id")).css({visibility: "visible"});
		})
		.mouseout(function(e) {
			var bubble = $(e.target);
			bubble = bubble.is('.bubble') ? bubble : bubble.parent();
			bubble.removeClass('bubbled');
			$('.control').css({visibility: "hidden"});
		});
});