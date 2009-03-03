module UserHelper
	def showPreviewJs
  "function showPreview(coords) {
    var rx = #{User::AVATAR_SW} / coords.w; var ry = #{User::AVATAR_SH} / coords.h;
    var ratio = #{@user.avatar_geometry(:original).width} / #{@user.avatar_geometry(:normal).width};
    $('#preview').css({
      width: Math.round(rx * #{@user.avatar_geometry(:normal).width.to_i}) + 'px',
      height: Math.round(ry * #{@user.avatar_geometry(:normal).height.to_i}) + 'px',
      marginLeft: '-' + Math.round(rx * coords.x) + 'px',
      marginTop: '-' + Math.round(ry * coords.y) + 'px'
    });
    $('#crop_x').val(Math.round(coords.x * ratio));
    $('#crop_y').val(Math.round(coords.y * ratio));
    $('#crop_w').val(Math.round(coords.w * ratio));
    $('#crop_h').val(Math.round(coords.h * ratio));
  }
  $(function() {
    $('#cropbox').Jcrop({
    onSelect: showPreview,
    onChange: showPreview,
    setSelect: [ 0, 0, 80, 80 ],
    aspectRatio: #{User::AVATAR_SW}/#{User::AVATAR_SH}});
  });"
	end
end
