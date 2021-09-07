/// @description After textbox closes special case code

// cityEntrance Himiko intro special case
if (room == rm_forestCityEntrance) {
	instance_destroy(obj_himiko);
	playTransitionSequence(seq_himiko_introEnd, 352, 352);
}