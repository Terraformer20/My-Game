/// @description Textbox drawing

// Change sprite based on state
if (myState == textboxState.idle) {
	sprite_index = spr_textbox_idle;
} else {
	sprite_index = spr_textbox_writing;
}

// Draw self duh
draw_self();

// Draw text
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_textbox);
draw_text_ext_color(x-sprite_width/2+16, y-sprite_height/2+8, textToShow, 48, 672, c_white, c_white, c_white, c_white, 255);

// Draw name box if applicable
if (nameToShow != undefined) {
	var _nameX = x-sprite_width/2+16;
	var _nameY = y-sprite_height/2-32;
	
	var _nameLength = string_length(nameToShow);
	var _fontSize = font_get_size(fnt_textbox);
	
	var _textWidth = string_width_ext(nameToShow, _fontSize+(_fontSize/2), 672);
	var _textHeight = string_height_ext(nameToShow, _fontSize+(_fontSize/2), 672)+16;
	
	draw_rectangle_color(_nameX-16, _nameY+_textHeight/2, _nameX+_textWidth+16, _nameY-_textHeight/2, c_white, c_white, c_white, c_white, false);
	draw_rectangle_color(_nameX-12, _nameY+_textHeight/2-4, _nameX+_textWidth+12, _nameY-_textHeight/2+4, c_black, c_black, c_black, c_black, false);
	
	draw_text_ext_color(_nameX, _nameY-22, nameToShow, 48, 672, c_white, c_white, c_white, c_white, 255);
}