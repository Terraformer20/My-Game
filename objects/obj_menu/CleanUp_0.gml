/// @description Destroy all menu pages

// Save settings for next time
global.settings = array_create(0);
array_push(global.settings,{name:"bgmVolume", value:global.bgmVolume});
array_push(global.settings,{name:"uiVolume", value:global.uiVolume});
for (var i = 2; i < ds_grid_height(menuPages[1]); i += 1) {
	array_push(global.settings, {name:menuPages[1][# 2, i], value:variable_global_get(menuPages[1][# 2, i])});
}

for (var i = 0; i < array_length(menuPages); i += 1) {
	ds_grid_destroy(menuPages[i]);
}