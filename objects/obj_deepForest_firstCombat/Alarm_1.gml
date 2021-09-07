/// @description Himiko Comes out and Talks

var himiko = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_himiko);
himiko.dir = obj_player.dir;
with (obj_himiko) {
	targetX = 436;
	targetY = 300;
	cutsceneSpeed = 1;
	alarm[7] = 1;
}
alarm[2] = 90;