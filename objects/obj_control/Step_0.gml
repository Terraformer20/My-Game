/// @description Insert description here

if (global.mainMenu) global.playerControl = false;

/**
if (keyboard_check_pressed(vk_space)) {
	if (myCamera == noone) {
		oldCamera = view_camera;
		myCamera = camera_create_view(0, 0, 704, 800, 0, obj_cameraFocus, -1, -1, 352, 352);
		view_set_camera(view_current, myCamera);
		show_debug_message("created");
	} else {
		camera_destroy(myCamera);
		myCamera = noone;
		view_set_camera(view_current, oldCamera);
		show_debug_message("deleted");
	}
}
**/