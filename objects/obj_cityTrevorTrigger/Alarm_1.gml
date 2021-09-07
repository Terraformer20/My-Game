/// @description Delete camera give back player control

camera_destroy(myCamera);
myCamera = noone;
view_set_camera(view_current, oldCamera);
show_debug_message("deleted");
global.playerControl = true;