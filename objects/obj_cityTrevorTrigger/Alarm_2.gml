/// @description Destroy himiko, recenter camera

instance_destroy(obj_himiko);
instance_destroy(obj_trevor);
instance_destroy(obj_skullcrusher);

with (obj_cameraFocus) {
	alarm[0] = 2;
}
alarm[1] = 135;