/// @description Draw choicebox and options

// Basic draw setup
draw_self();
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_textbox);

if (options != undefined) {
	// Draw Prompt Text
	draw_text_ext_color(x, y-sprite_height/4, textToShow, 10, sprite_width, c_white, c_white, c_white, c_white, 255);

	 // Draw Options Text
	 _optionsLength = array_length(options);
	 for (var i = 0; i < _optionsLength; i += 1) {
		 draw_text_ext_color(sprite_width/(_optionsLength+1)*(i+1), y+sprite_height/4-20, options[i], 10, sprite_width/(_optionsLength+2), c_white, c_white, c_white, c_white, 255);
	 }
} 