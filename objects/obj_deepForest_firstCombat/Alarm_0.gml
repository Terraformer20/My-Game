/// @description Begin Cutscene

if (!global.triggers[2]) {
	global.triggers[2] = true;
	global.playerControl = false;
	createDefaultNamedTextbox("Wait a sec " + global.playerName + ".", self, "Himiko");
}