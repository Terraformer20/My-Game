/// @description Restore everything
obj_player.image_alpha = 255;
for (var i = 0; i < array_length(global.units); i += 1) {
	instance_destroy(global.units[i]);
}