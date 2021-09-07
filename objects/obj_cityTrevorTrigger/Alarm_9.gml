/// @description Create Himiko Instance and Face correct dir

himiko = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_himiko);
himiko.targetX = 526;
himiko.targetY = 655;
himiko.cutsceneSpeed = 0.5;
himiko.giveControl = false;
himiko.alarm[7] = 2; 
alarm[8] = 110;