// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function playUIAudio(soundid) {
	var _sound = audio_play_sound(soundid, 10, false);
	audio_sound_gain(_sound, global.uiVolume, 0);
}
function playBGMAudio(soundid) {
	var _sound = audio_play_sound(soundid, 10, true);
	audio_sound_gain(_sound, global.bgmVolume, 0);
}