jQuery.expr[':'].regex = function(elem, index, match) {
	var matchParams = match[3].split(','),
	validLabels = /^(data|css):/,
		attr = {
	    method: matchParams[0].match(validLabels) ?
	    	matchParams[0].split(':')[0] : 'attr', property: matchParams.shift().replace(validLabels,'')
    },
	regexFlags = 'ig', regex = new RegExp(matchParams.join('').replace(/^\s+|\s+$/g,''), regexFlags);
	return regex.test(jQuery(elem)[attr.method](attr.property));
}
$(document).ready(function() {
	var $result = $("#results p")
	$('.bubble')
		.mouseover(function(e) {
			var bubble = $(e.target);
			bubble = bubble.is('.bubble') ? bubble : bubble.parent();
			bubble = bubble.is('.control') ? bubble.parent() : bubble;
			bubble.addClass("bubbled");
			$("#ctrl_" + bubble.attr("id").split("_")[1]).css({visibility: "visible"})
			$result.text($(e.target))
		})
		.mouseout(function(e) {
			var bubble = $(e.target);
			bubble = bubble.is('.bubble') ? bubble : bubble.parent();
			bubble.removeClass('bubbled');
			$('.control').css({visibility: "hidden"});
		});
	$(':regex(level, ^[0-9])').map(function(count, el) {
		var pos = $(el).attr("level");
		$(el).css({'margin-left': pos + 'em'});
	});

	$('.bubble').corners();
});
