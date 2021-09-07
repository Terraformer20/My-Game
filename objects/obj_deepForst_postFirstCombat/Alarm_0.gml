/// @description Restore player control and delete self

global.playerControl = true;
instance_destroy(obj_himiko);
instance_destroy(self);