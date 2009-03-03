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
	//$('.accordion').accordion({ header: "h2" });
	//$('.accordion h2').css({cursor: 'pointer'});
	$("#toolbar").corners("bottom");
	$('.bubble')
		.corners()
		.mouseover(function(e) {
			var bubble = $(e.target);
			bubble = bubble.is('.bubble') ? bubble : bubble.parent();
			bubble = bubble.is('.control') ? bubble.parent() : bubble;
			bubble.addClass("bubbled");
			$("#control_" + bubble.attr("id").split("_")[1]).css({visibility: "visible"})
		})
		.mouseout(function(e) {
			var bubble = $(e.target);
			bubble = bubble.is('.bubble') ? bubble : bubble.parent();
			$(":hasClass('bubbled')").removeClass('bubbled');
			$('.control').css({visibility: "hidden"});
		});
	$(':regex(level, ^[0-9])').map(function(count, el) {
		var pos = $(el).attr("level");
		$(el).css({'margin-left': pos + 'em'});
	});
});

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
