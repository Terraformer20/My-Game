/// @description Post combat
switch(room) {
	case rm_deepForest_entrance: {
		instance_create_layer(x, y, "Instances", obj_deepForst_postFirstCombat);
	}; break;
}